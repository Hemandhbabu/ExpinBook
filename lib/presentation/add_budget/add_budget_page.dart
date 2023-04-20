import '../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/budget.dart';
import 'add_budget_provider.dart';
import 'components/amount_card.dart';
import 'components/category_budget_card.dart';
import 'components/name_card.dart';
import 'components/type_card.dart';

class AddBudgetPage extends StatelessWidget {
  static const route = 'add-budget-page';
  final Budget? budget;
  const AddBudgetPage({super.key, this.budget});

  List<Override> buildOverrides() {
    final budget = this.budget;
    if (budget == null) return [];
    return [
      AddBudgetProvider.nameProvider.overrideWith((ref) => budget.name),
      AddBudgetProvider.amountProvider.overrideWith((ref) => budget.amount),
      AddBudgetProvider.isTotalBudgetProvider.overrideWith(
        (ref) => budget.budgetForCategories.isEmpty,
      ),
      AddBudgetProvider.budgetCategoriesProvider.overrideWith(
        (ref) => BudgetCategoriesNotifier(budget.budgetForCategories),
      ),
      AddBudgetProvider.validatorProvider.overrideWith(
        AddBudgetProvider.validator,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: buildOverrides(),
      child: Scaffold(
        appBar: CustomAppBar.elevated(
          provider: AddBudgetProvider.elevatedProvider,
          title: '${budget == null ? 'Add' : 'Edit'} budget',
          actions: [
            if (budget != null)
              Consumer(
                builder: (context, ref, child) {
                  return IconButton(
                    onPressed: () => AddBudgetProvider.delete(
                      context,
                      ref.read,
                      budget!,
                    ).then(
                      (value) => value == true ? Navigator.pop(context) : null,
                    ),
                    color: Colors.red,
                    icon: const Icon(Icons.delete_rounded),
                  );
                },
              ),
            Consumer(
              builder: (context, ref, child) {
                final valid = ref.watch(
                  AddBudgetProvider.validatorProvider(budget),
                );
                return IconButton(
                  onPressed: valid
                      ? () => AddBudgetProvider.save(
                            context,
                            ref.read,
                            budget?.id ?? -1,
                          )
                      : null,
                  icon: const Icon(Icons.save_rounded),
                );
              },
            ),
          ],
        ),
        body: ScrollNotificationWrapper(
          provider: AddBudgetProvider.elevatedProvider,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            children: const [
              NameCard(),
              SizedBox(height: 12),
              AmountCard(),
              SizedBox(height: 12),
              TypeCard(),
              SizedBox(height: 12),
              CategoryBudgetCard(),
            ],
          ),
        ),
      ),
    );
  }
}
