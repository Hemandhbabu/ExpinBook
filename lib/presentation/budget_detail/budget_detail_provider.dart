import 'dart:convert';

import 'package:flutter/foundation.dart' show compute;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/budget.dart';
import '../../domain/models/category.dart';
import '../../domain/models/category_data.dart';
import '../../domain/models/expin.dart';
import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import '../../utils/my_datetime.dart';
import '../../utils/my_iterable.dart';
import '../utils/date_filter.dart';
import 'budget_detail_data.dart';

class BudgetDetailProvider {
  const BudgetDetailProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final _budgetProvider = StreamProvider.autoDispose.family(
    (ref, int id) => ref.watch(
      budgetUseCasesProvider.select(
        (value) => value.getBudget.watchWithId(id),
      ),
    ),
  );

  static final _filteredCategoriesProvider = StreamProvider.autoDispose.family(
    (ref, String json) {
      final budgetForCategories = (jsonDecode(json) as List).cast<int>();
      return ref
          .watch(
            categoryUseCasesProvider.select((v) => v.getAllCategory),
          )
          .watchAll()
          .map(
            (value) => value
                .where(
                  (e) =>
                      !e.isIncome &&
                      (budgetForCategories.isEmpty
                          ? true
                          : budgetForCategories.contains(e.id)),
                )
                .toList(),
          );
    },
  );

  static final _categoriesProvider = Provider.autoDispose.family(
    (ref, int id) {
      final budget = ref.watch(_budgetProvider(id));
      return budget.merge(
        (budget) => budget == null
            ? const AsyncData(<Category>[])
            : ref.watch(
                _filteredCategoriesProvider(
                  jsonEncode(budget.budgetForCategories),
                ),
              ),
      );
    },
  );

  static final _filteredExpinsProvider =
      StreamProvider.autoDispose.family((ref, String json) {
    final now = DateTime.now();
    final budgetForCategories = (jsonDecode(json) as List).cast<int>();
    return ref
        .watch(expinUseCasesProvider.select((value) => value.getAllExpin))
        .watchAll()
        .map(
          (value) => value
              .where(
                (e) =>
                    e.isExpense &&
                    (e.dateTime.format('yM') == now.format('yM')) &&
                    (budgetForCategories.isEmpty
                        ? true
                        : budgetForCategories.contains(e.categoryId)),
              )
              .toList(),
        );
  });

  static final _expinsProvider = Provider.autoDispose.family(
    (ref, int id) {
      final budget = ref.watch(_budgetProvider(id));
      return budget.merge(
        (budget) => budget == null
            ? const AsyncData(<Expin>[])
            : ref.watch(
                _filteredExpinsProvider(jsonEncode(budget.budgetForCategories)),
              ),
      );
    },
  );

  static final budgetDetailProvider = Provider.autoDispose.family(
    (ref, int id) {
      final budget = ref.watch(_budgetProvider(id));
      final expins = ref.watch(_expinsProvider(id));
      final categories = ref.watch(_categoriesProvider(id));
      return budget.merge(
        (budget) => budget == null
            ? const AsyncData(null)
            : expins.merge(
                (expins) => categories.merge(
                  (categories) {
                    final jsonList = [
                      budget.toJson(),
                      jsonEncode(expins.map((e) => e.toJson()).toList()),
                      jsonEncode(categories.map((e) => e.toJson()).toList()),
                    ];
                    return ref.watch(
                      _convertedDataProvider(jsonEncode(jsonList)),
                    );
                  },
                ),
              ),
      );
    },
  );

  static final _convertedDataProvider = FutureProvider.autoDispose.family(
    (ref, String json) => compute(_convertData, json),
  );
}

BudgetDetailData? _convertData(String json) {
  final data = (jsonDecode(json) as List).cast<String>();
  final budget = Budget.fromJson(data[0]);
  final now = DateTime.now();
  final expins = (jsonDecode(data[1]) as List)
      .cast<String>()
      .map((e) => Expin.fromJson(e));
  final categories = (jsonDecode(data[2]) as List)
      .cast<String>()
      .map((e) => Category.fromJson(e));
  return BudgetDetailData(
    budget: budget,
    categories: categories.map(
      (e) {
        final filtered =
            expins.where((i) => i.categoryId == e.id).map((e) => e.amount);
        return CategoryData(
          category: e,
          amount: filtered.addition,
          noOfTransactions: filtered.length,
          filter: DateFilter.month(now),
        );
      },
    ).toList()
      ..sort((o, t) => t.amount.compareTo(o.amount)),
  );
}
