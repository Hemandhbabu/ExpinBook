import 'dart:convert';

import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import 'package:flutter/foundation.dart' show compute;

import '../../domain/models/category.dart';
import '../utils/type_filter_list_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoriesProvider {
  const CategoriesProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final _categoriesProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(
      categoryUseCasesProvider.select(
        (value) => value.getAllCategory.watchAll(),
      ),
    ),
  );

  static final _convertedDataProvider = FutureProvider.autoDispose.family(
    (ref, String json) => compute(_convertData, json),
  );

  static final categoriesProvider = Provider.autoDispose((ref) {
    return ref.watch(_categoriesProvider).merge(
          (value) => ref.watch(
            _convertedDataProvider(
              jsonEncode(value.map((e) => e.toJson()).toList()),
            ),
          ),
        );
  });
}

List<TypeFilterListData<Category>> _convertData(String json) {
  final categories = (jsonDecode(json) as List)
      .cast<String>()
      .map((e) => Category.fromJson(e));
  final income = categories.where((element) => element.isIncome).toList()
    ..sort((o, t) => o.id!.compareTo(t.id!));
  final expense = categories.where((element) => !element.isIncome).toList()
    ..sort((o, t) => o.id!.compareTo(t.id!));
  return <TypeFilterListData<Category>>[
    if (income.isNotEmpty) const TypeFilterListData.title(true),
    ...income.map((e) => TypeFilterListData.value(e)),
    if (expense.isNotEmpty) const TypeFilterListData.title(false),
    ...expense.map((e) => TypeFilterListData.value(e)),
  ];
}
