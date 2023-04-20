import '../../provider/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/budget.dart';
import '../../provider/use_cases_provider.dart';
import '../../utils/snack_bar_data.dart';
import '../../utils/snack_bar_utils.dart';
import '../../utils/type_def_utils.dart';
import '../utils/dialog_utils.dart';

class AddBudgetProvider {
  const AddBudgetProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final nameProvider = StateProvider.autoDispose((ref) => '');

  static final amountProvider = StateProvider.autoDispose((ref) => 0.0);

  static final isTotalBudgetProvider = StateProvider.autoDispose((ref) => true);

  static final budgetCategoriesProvider =
      StateNotifierProvider.autoDispose<BudgetCategoriesNotifier, List<int>>(
    (ref) => BudgetCategoriesNotifier(),
  );

  static final validatorProvider = Provider.autoDispose.family(validator);

  static bool validator(AutoDisposeProviderRef ref, Budget? budget) {
    final name = ref.watch(nameProvider);
    final amount = ref.watch(amountProvider);
    final categories = ref.watch(budgetCategoriesProvider);
    var result = name.isNotEmpty;
    if (result) result = amount > 0;
    if (budget == null) return result;
    if (result) {
      return Budget(
            id: budget.id,
            name: name,
            amount: amount,
            budgetForCategories: categories,
          ) !=
          budget;
    } else {
      return false;
    }
  }

  static void save(BuildContext context, Reader read, int id) {
    final budget = Budget(
      id: id > 0 ? id : null,
      name: read(nameProvider),
      amount: read(amountProvider),
      budgetForCategories: read(budgetCategoriesProvider),
    );
    final dao = read(budgetUseCasesProvider);
    if (id > 0) {
      dao.modifyBudget.update(budget).then(
        (value) {
          if (value) Navigator.pop(context);
          showSnackBar(
            SnackBarData(
              message: value
                  ? 'Budget updated successfully'
                  : 'Error while updating budget',
            ),
          );
        },
      );
    } else {
      dao.modifyBudget.add(budget).then(
        (value) {
          if (value) Navigator.pop(context);
          showSnackBar(
            SnackBarData(
              message: value
                  ? 'Budget added successfully'
                  : 'Error while adding budget',
            ),
          );
        },
      );
    }
  }

  static Future<bool?> delete(
          BuildContext context, Reader read, Budget budget) =>
      showCustomDialog(
        context: context,
        title: 'Are you sure ?',
        content: 'Do you want to delete this budget ?',
        actionsBuilder: (context) => [
          CustomDialogAction(
            text: 'No',
            onTap: () => Navigator.pop(context),
          ),
          CustomDialogAction(
            text: 'Yes',
            onTap: () {
              Navigator.pop(context, true);
              final pinnedId = read(pinnedBudgetPreferencesProvider);
              if (pinnedId == budget.id) {
                read(pinnedBudgetPreferencesProvider.notifier).setInt(-1);
              }
              read(budgetUseCasesProvider).modifyBudget.delete(budget);
              showSnackBar(
                const SnackBarData(message: 'Budget deleted'),
              );
            },
          ),
        ],
      );
}

class BudgetCategoriesNotifier extends StateNotifier<List<int>> {
  BudgetCategoriesNotifier([List<int> categories = const []])
      : super(categories);

  void add(int category) {
    final local = [...state];
    if (local.contains(category)) return;
    local.add(category);

    state = local;
  }

  void remove(int category) {
    final local = [...state];
    if (local.remove(category)) state = local;
  }

  void update(List<int> categories) => state = [...categories];

  void clear() => state = [];
}
