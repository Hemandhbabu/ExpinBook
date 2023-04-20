import 'dart:convert';

import 'package:flutter/foundation.dart' show compute;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/budget.dart';
import '../../provider/preferences_provider.dart';
import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import '../../utils/my_iterable.dart';
import '../utils/type_filter_list_data.dart';

class BudgetsProvider {
  const BudgetsProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final _budgetsProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(
      budgetUseCasesProvider.select(
        (value) => value.getAllBudget.watchAll(),
      ),
    ),
  );

  static final budgetsProvider = Provider.autoDispose((ref) {
    final pinnedId = ref.watch(pinnedBudgetPreferencesProvider);
    final budgets = ref.watch(_budgetsProvider);
    return budgets.merge(
      (budgets) {
        final jsonList = [
          '$pinnedId',
          jsonEncode(budgets.map((e) => e.toJson()).toList()),
        ];
        final json = jsonEncode(jsonList);
        return ref.watch(_convertedDataProvider(json));
      },
    );
  });

  static final _convertedDataProvider = FutureProvider.autoDispose.family(
    (ref, String json) => compute(_convertData, json),
  );
}

List<TypeFilterListData<Budget>> _convertData(String json) {
  final jsonList = (jsonDecode(json) as List).cast<String>();
  final pinnedId = int.parse(jsonList[0]).let((id) => id == -1 ? null : id);
  final budgets = (jsonDecode(jsonList[1]) as List)
      .cast<String>()
      .map(Budget.fromJson)
      .toList();
  if (pinnedId == null) {
    return budgets.map(TypeFilterListData.value).toList();
  }
  final pinnedBudget = budgets.findItem((item) => item.id == pinnedId);

  if (pinnedBudget == null) {
    return budgets.map(TypeFilterListData.value).toList();
  }
  budgets.removeWhere((element) => element.id == pinnedId);
  return <TypeFilterListData<Budget>>[
    const TypeFilterListData.title(true),
    TypeFilterListData.value(pinnedBudget),
    const TypeFilterListData.title(false),
    ...budgets.map(TypeFilterListData.value),
  ];
}
