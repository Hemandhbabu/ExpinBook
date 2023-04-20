import 'dart:convert';

import 'package:flutter/foundation.dart' show compute;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/category.dart';
import '../../domain/models/category_data.dart';
import '../../domain/models/expin.dart';
import '../../provider/preferences_provider.dart' as pre;
import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import '../../utils/my_datetime.dart';
import '../../utils/my_iterable.dart';
import '../utils/date_filter.dart';
import '../utils/type_filter_list_data.dart';

class PinnedCategoriesProvider {
  const PinnedCategoriesProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);
  static final manageElevatedProvider =
      StateProvider.autoDispose((ref) => false);

  static final _thisMonthExpinsProvider = StreamProvider.autoDispose(
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

  static final manageIncomePinnedCategoriesProvider =
      StateNotifierProvider.autoDispose<_PinnedCategoriesNotifier, List<int>>(
    (ref) => _PinnedCategoriesNotifier(
      ref.watch(pinnedCategoriesProvider).maybeWhen(
            orElse: () => [],
            data: (data) => data
                .reduceToField(
                  (item) => item.maybeWhen(
                    orElse: () => null,
                    value: (category) => category.category,
                  ),
                  (one, two) => one.id == two.id,
                )
                .where((element) => element.isIncome)
                .map((e) => e.id!)
                .toList(),
          ),
    ),
  );

  static final manageExpensePinnedCategoriesProvider =
      StateNotifierProvider.autoDispose<_PinnedCategoriesNotifier, List<int>>(
    (ref) => _PinnedCategoriesNotifier(
      ref.watch(pinnedCategoriesProvider).maybeWhen(
            orElse: () => [],
            data: (data) => data
                .reduceToField(
                  (item) => item.maybeWhen(
                    orElse: () => null,
                    value: (category) => category.category,
                  ),
                  (one, two) => one.id == two.id,
                )
                .where((element) => !element.isIncome)
                .map((e) => e.id!)
                .toList(),
          ),
    ),
  );

  static final categoriesProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(
      categoryUseCasesProvider.select(
        (value) => value.getAllCategory.watchAll().map(
          (value) {
            final categories = [...value];
            final income = categories
                .where((element) => element.isIncome)
                .toList()
              ..sort((o, t) => o.id!.compareTo(t.id!));
            final expense = categories
                .where((element) => !element.isIncome)
                .toList()
              ..sort((o, t) => o.id!.compareTo(t.id!));
            return <TypeFilterListData<Category>>[
              const TypeFilterListData.title(true),
              ...income.map((e) => TypeFilterListData.value(e)),
              const TypeFilterListData.title(false),
              ...expense.map((e) => TypeFilterListData.value(e)),
            ];
          },
        ),
      ),
    ),
  );

  static final pinnedCategoriesProvider = Provider.autoDispose(
    (ref) {
      final pinnedCategories = ref.watch(pre.pinnedCategoriesProvider);
      final expins = ref.watch(_thisMonthExpinsProvider);
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

List<TypeFilterListData<CategoryData>> _convertData(String json) {
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
  final income = categories.where((element) => element.category.isIncome);
  final expense = categories.where((element) => !element.category.isIncome);
  return <TypeFilterListData<CategoryData>>[
    if (income.isNotEmpty) const TypeFilterListData.title(true),
    ...income.map((e) => TypeFilterListData.value(e)),
    if (expense.isNotEmpty) const TypeFilterListData.title(false),
    ...expense.map((e) => TypeFilterListData.value(e)),
  ];
}

class _PinnedCategoriesNotifier extends StateNotifier<List<int>> {
  _PinnedCategoriesNotifier(List<int> categories) : super([...categories]);

  void addCategory(int value) {
    final local = [...state];
    if (!local.contains(value)) {
      local.add(value);
      state = [...local];
    }
  }

  void removeCategory(int value) {
    final local = [...state];
    if (local.contains(value)) {
      local.removeWhere((element) => element == value);
      state = [...local];
    }
  }
}
