import 'dart:convert';

import 'home_data.dart';
import 'package:flutter/foundation.dart' show compute;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/category.dart';
import '../../domain/models/category_data.dart';
import '../../domain/models/expin.dart';
import '../../provider/preferences_provider.dart' as pro;
import '../../provider/preferences_provider.dart';
import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import '../../utils/my_datetime.dart';
import '../../utils/my_iterable.dart';
import '../utils/date_filter.dart';

class HomeProvider {
  const HomeProvider._();
  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final homeDataProvider = Provider.autoDispose((ref) {
    final recentTransactions = ref.watch(_recentTransactionsProvider);
    final pinnedCategories = ref.watch(_pinnedCategoriesProvider);
    final budget = ref.watch(_budgetProvider);
    return recentTransactions.merge(
      (recentTransactions) => pinnedCategories.merge(
        (pinnedCategories) => budget.whenData(
          (budget) => HomeData(
            expins: recentTransactions,
            pinnedCategories: pinnedCategories,
            budget: budget,
          ),
        ),
      ),
    );
  });

  static final _homeExpinDataProvider = StreamProvider.autoDispose(
    (ref) {
      final now = DateTime.now();
      return ref.watch(
        expinDataUseCasesProvider.select(
          (value) => value.getAllExpinData.watchAll().map(
                (value) => value
                    .where(
                        (e) => e.expin.dateTime.filter(DateFilter.month(now)))
                    .toList(),
              ),
        ),
      );
    },
  );

  static final _recentTransactionsProvider = Provider.autoDispose(
    (ref) => ref.watch(
      _homeExpinDataProvider.select(
        (value) => value.whenData((value) => value.take(5).toList()),
      ),
    ),
  );

  static final homeExpinsProvider = StreamProvider.autoDispose(
    (ref) {
      final now = DateTime.now();
      return ref.watch(
        expinUseCasesProvider.select(
          (value) => value.getAllExpin.watchAll().map(
                (value) => value
                    .where((e) => e.dateTime.filter(DateFilter.month(now)))
                    .toList(),
              ),
        ),
      );
    },
  );

  static final _budgetProvider = StreamProvider.autoDispose(
    (ref) {
      final budgetId = ref
          .watch(pinnedBudgetPreferencesProvider)
          .let((id) => id == -1 ? null : id);
      final getBudget = ref.watch(
        budgetUseCasesProvider.select((value) => value.getBudget),
      );
      return budgetId?.let((id) => getBudget.watchWithId(id)) ??
          getBudget.watchFirst();
    },
  );

  static final _pinnedCategoriesProvider = Provider.autoDispose(
    (ref) {
      final pinnedCategories = ref.watch(pro.pinnedCategoriesProvider);
      final expins = ref.watch(homeExpinsProvider);
      return pinnedCategories.merge(
        (pinnedCategories) => expins.merge(
          (expins) {
            final jsonList = [
              jsonEncode(pinnedCategories.map((e) => e.toJson()).toList()),
              jsonEncode(expins.map((e) => e.toJson()).toList()),
            ];
            final json = jsonEncode(jsonList);
            return ref.watch(_convertedDataProvider(json));
          },
        ),
      );
    },
  );

  static final _convertedDataProvider = FutureProvider.autoDispose.family(
    (ref, String json) => compute(_convertData, json),
  );
}

List<CategoryData> _convertData(String json) {
  final jsonList = (jsonDecode(json) as List).cast<String>();
  final filter = DateFilter.month(DateTime.now());
  final pinnedCategories = (jsonDecode(jsonList[0]) as List)
      .cast<String>()
      .map((e) => Category.fromJson(e));
  final expins = (jsonDecode(jsonList[1]) as List)
      .cast<String>()
      .map((e) => Expin.fromJson(e));
  final categories = pinnedCategories.map(
    (e) {
      final filtered = expins
          .where((element) => element.categoryId == e.id)
          .map((e) => e.amount);
      return CategoryData(
        filter: filter,
        category: e,
        amount: filtered.addition,
        noOfTransactions: filtered.length,
      );
    },
  ).toList();
  categories.sort((o, t) => t.amount.compareTo(o.amount));
  return <CategoryData>[
    ...categories.where((element) => element.category.isIncome).take(3),
    ...categories.where((element) => !element.category.isIncome).take(3),
  ];
}
