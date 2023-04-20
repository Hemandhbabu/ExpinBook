import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/my_datetime.dart';
import '../../utils/my_iterable.dart';
import '../add_budget/add_budget_arg.dart';
import '../add_budget/add_budget_page.dart';
import '../core/category_transactions_tile.dart';
import '../core_package/core_widget.dart';
import 'budget_detail_provider.dart';
import 'components/amount_info.dart';
import 'components/budget_chart.dart';
import 'components/left_amount_info.dart';
import 'components/type_info.dart';

class BudgetDetailPage extends ConsumerWidget {
  static const route = 'budget-detail-page';
  final int id;
  const BudgetDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncWidgetWrapper(
      asyncValue: ref.watch(BudgetDetailProvider.budgetDetailProvider(id)),
      nullBuilder: (context) {
        Future.delayed(Duration.zero, () => Navigator.pop(context));
        return const CenterText('An error occured');
      },
      loadingBuilder: (context) => const LoadingList(),
      builder: (context, budgetData) => Scaffold(
        appBar: CustomAppBar.elevated(
          provider: BudgetDetailProvider.elevatedProvider,
          title: budgetData.budget.name,
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                AddBudgetPage.route,
                arguments: AddBudgetArg(budget: budgetData.budget),
              ),
              icon: const Icon(Icons.edit_rounded),
            ),
          ],
        ),
        body: () {
          final budget = budgetData.budget;
          final categories = budgetData.categories;
          final categoriesLength = budget.budgetForCategories.length;
          return ScrollNotificationWrapper(
            provider: BudgetDetailProvider.elevatedProvider,
            child: ListView(
              children: [
                TypeInfo(
                  isTotal: categoriesLength == 0,
                  isSingleCategory: categoriesLength == 1,
                ),
                const SizedBox(height: 8),
                AmountInfo(amount: budget.amount),
                const SizedBox(height: 8),
                LeftAmountInfo(
                  amount:
                      budget.amount - categories.map((e) => e.amount).addition,
                ),
                const SizedBox(height: 8),
                BudgetChart(budgetDetailData: budgetData),
                const SizedBox(height: 12),
                TitleCard(
                  title: 'Categor${categoriesLength == 1 ? 'y' : 'ies'}',
                ),
                ...categories.map(
                  (e) => CategoryTransactionsTile(categoryData: e),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Note :\nThis spend amount is based on the month '
                    '"${DateTime.now().format('yMMMM')}"',
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ),
              ],
            ),
          );
        }(),
      ),
    );
  }
}
