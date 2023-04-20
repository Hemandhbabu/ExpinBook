import 'dart:convert';

import '../../core_package/shimmer.dart';
import '../../../provider/preferences_provider.dart';
import '../../../provider/use_cases_provider.dart';

import '../../../utils/my_datetime.dart';

import '../../add_budget/add_budget_arg.dart';
import '../../add_budget/add_budget_page.dart';
import '../../add_budget/add_budget_provider.dart';
import '../../budget_detail/budget_detail_page.dart';
import '../../core/currency_text.dart';
import '../../../utils/my_iterable.dart';
import '../../../utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/budget.dart';
import '../../core/custom_progress.dart';
import '../../core_package/core_widget.dart';
import '../../utils/show_action_utils.dart';

final _expenseProvider = StreamProvider.autoDispose.family(
  (ref, String json) {
    final ids = (jsonDecode(json) as List).cast<int>();
    final now = DateTime.now();
    return ref.watch(
      expinUseCasesProvider.select(
        (value) => value.getAllExpin.watchAll().map(
              (value) => value
                  .where(
                    (e) =>
                        e.isExpense &&
                        (e.dateTime.format('yM') == now.format('yM')) &&
                        (ids.isEmpty ? true : ids.contains(e.categoryId)),
                  )
                  .map((e) => e.amount)
                  .addition,
            ),
      ),
    );
  },
);

class BudgetTile extends ConsumerWidget {
  final Budget budget;
  const BudgetTile({super.key, required this.budget});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = budget.budgetForCategories;
    final asyncExpense = ref.watch(_expenseProvider(jsonEncode(categories)));
    final expense = asyncExpense.maybeWhen(orElse: () => 0.0, data: (e) => e);
    final amount = budget.amount;
    final left = amount - expense;
    final percent = amount <= 0 ? 0.0 : expense / amount;
    final isPinned = ref.watch(
      pinnedBudgetPreferencesProvider.select((id) => id == budget.id),
    );
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () => Navigator.pushNamed(
          context,
          BudgetDetailPage.route,
          arguments: budget.id,
        ),
        onLongPress: () => showCustomAction(
          context,
          tile: this,
          TileActionData(
            actions: [
              TileAction(
                icon: Icons.push_pin_rounded,
                text: '${isPinned ? 'Unpin' : 'Pin'} budget',
                value: 0,
              ),
              const TileAction(
                icon: Icons.edit_rounded,
                text: 'Edit budget',
                iconColor: Colors.blue,
                tileColor: Colors.blue,
                value: 1,
              ),
              const TileAction(
                icon: Icons.delete_rounded,
                text: 'Delete budget',
                iconColor: Colors.red,
                tileColor: Colors.red,
                value: 2,
              ),
            ],
            valueChanged: (value) {
              if (value == 1) {
                Navigator.pushNamed(
                  context,
                  AddBudgetPage.route,
                  arguments: AddBudgetArg(budget: budget),
                );
              } else if (value == 2) {
                AddBudgetProvider.delete(context, ref.read, budget);
              } else if (value == 0) {
                ref
                    .read(pinnedBudgetPreferencesProvider.notifier)
                    .setInt(isPinned ? -1 : budget.id!);
              }
            },
          ),
        ),
        child: Column(
          children: [
            CustomTile(
              title: budget.name,
              subtitleSize: 14,
              subtitle:
                  '${categories.isEmpty ? 'Total' : categories.length == 1 ? 'Category' : 'Categories'} budget',
              color: Colors.transparent,
              margin: const EdgeInsets.fromLTRB(12, 4, 12, 0),
              trailing: CurrencyText(
                budget.amount,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 4),
            Shimmer(
              child: ShimmerLoading(
                isLoading: asyncExpense.maybeWhen(
                  orElse: () => false,
                  loading: () => true,
                ),
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 28),
                      title: Text(
                        'Budget ${left < 0 ? 'exceeded by' : 'left to spend'}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: CurrencyText(
                        left < 0 ? -left : left,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: left < 0 ? Colors.red : null,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      child:
                          CustomLinearProgress(value: percent, minHeight: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
