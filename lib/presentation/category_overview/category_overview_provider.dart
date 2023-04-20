import 'dart:convert';

import '../../domain/models/expin.dart';
import 'package:flutter/foundation.dart' show compute;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/category.dart';
import '../../domain/models/category_data.dart';
import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import '../../utils/my_datetime.dart';
import '../../utils/my_iterable.dart';
import '../utils/category_filter.dart';
import '../utils/date_filter.dart';
import '../utils/type_filter_list_data.dart';

class CategoryOverviewProvider {
  const CategoryOverviewProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final dateFilterProvider = StateProvider.autoDispose(
    (ref) => DateFilter.month(DateTime.now()),
  );

  static final categoryFilterProvider =
      StateProvider.autoDispose((ref) => const CategoryFilter.categories([]));

  static final filteredExpinsProvider = StreamProvider.autoDispose((ref) {
    final category = ref.watch(categoryFilterProvider);
    final date = ref.watch(dateFilterProvider);
    return ref.watch(
      expinUseCasesProvider.select(
        (value) => value.getAllExpin.watchAll().map(
              (expins) => expins
                  .where(
                    (e) =>
                        e.dateTime.filter(date) &&
                        category.when(
                          all: () => true,
                          income: () => e.isIncome,
                          expense: () => e.isExpense,
                          transfer: () => e.isTransfer,
                          category: (category) => category.id == e.categoryId,
                          categories: (categories) => categories
                              .map((e) => e.id)
                              .contains(e.categoryId),
                        ),
                  )
                  .toList(),
            ),
      ),
    );
  });

  static final _categoriesProvider = StreamProvider.autoDispose(
    (ref) => ref
        .watch(categoryUseCasesProvider.select((value) => value.getAllCategory))
        .watchAll(),
  );

  static final categoriesOverviewProvider = Provider.autoDispose((ref) {
    final date = ref.watch(dateFilterProvider);
    final category = ref.watch(categoryFilterProvider);
    final expins = ref.watch(filteredExpinsProvider);
    final categories = ref.watch(_categoriesProvider);
    return expins.merge(
      (expins) => categories.merge(
        (categories) {
          final jsonList = [
            jsonEncode(date.toJson()),
            jsonEncode(category.toJson()),
            jsonEncode(expins.map((e) => e.toJson()).toList()),
            jsonEncode(categories.map((e) => e.toJson()).toList()),
          ];
          final json = jsonEncode(jsonList);
          return ref.watch(_convertedDataProvider(json));
        },
      ),
    );
  });

  static final _convertedDataProvider = FutureProvider.autoDispose.family(
    (ref, String json) => compute(_convertData, json),
  );
}

List<TypeFilterListData<CategoryData>> _convertData(String json) {
  final jsonList = (jsonDecode(json) as List).cast<String>();
  final date = DateFilter.fromJson(
    (jsonDecode(jsonList[0]) as Map).cast<String, dynamic>(),
  );
  final category = CategoryFilter.fromJson(
    (jsonDecode(jsonList[1]) as Map).cast<String, dynamic>(),
  );
  final expins = (jsonDecode(jsonList[2]) as List)
      .cast<String>()
      .map((e) => Expin.fromJson(e));
  final categories = (jsonDecode(jsonList[3]) as List)
      .cast<String>()
      .map((e) => Category.fromJson(e));
  final categoryDatas = categories
      .where(
    (element) => category.when(
      all: () => true,
      income: () => element.isIncome,
      expense: () => !element.isIncome,
      transfer: () => false,
      category: (category) => category.id == element.id,
      categories: (categories) =>
          categories.map((e) => e.id).contains(element.id),
    ),
  )
      .map(
    (e) {
      final filtered = expins
          .where((element) => element.categoryId == e.id)
          .map((e) => e.amount);
      return CategoryData(
        category: e,
        amount: filtered.addition,
        noOfTransactions: filtered.length,
        filter: date,
      );
    },
  ).toList();
  categoryDatas.sort((o, t) => o.category.id!.compareTo(t.category.id!));
  final income =
      categoryDatas.where((element) => element.category.isIncome).toList();
  income.sort((o, t) => t.amount.compareTo(o.amount));
  final expense =
      categoryDatas.where((element) => !element.category.isIncome).toList();
  expense.sort((o, t) => t.amount.compareTo(o.amount));
  return <TypeFilterListData<CategoryData>>[
    if (income.isNotEmpty) const TypeFilterListData.title(true),
    ...income.map((e) => TypeFilterListData.value(e)),
    if (expense.isNotEmpty) const TypeFilterListData.title(false),
    ...expense.map((e) => TypeFilterListData.value(e)),
  ];
}
