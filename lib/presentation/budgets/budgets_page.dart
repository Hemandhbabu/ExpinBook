import 'package:flutter/material.dart';

import '../../utils/my_datetime.dart';
import '../add_budget/add_budget_page.dart';
import '../core_package/core_widget.dart';
import 'budgets_provider.dart';
import 'components/budget_tile.dart';

class BudgetsPage extends StatelessWidget {
  static const route = 'budgets-page';
  const BudgetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: BudgetsProvider.elevatedProvider,
        title: 'Budgets',
        actions: [
          IconButton(
            tooltip: 'Add budget',
            onPressed: () => Navigator.pushNamed(context, AddBudgetPage.route),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: ScrollNotificationWrapper(
        provider: BudgetsProvider.elevatedProvider,
        builder: (context, ref, child) => CustomListView.async(
          hasFab: true,
          asyncValue: ref.watch(BudgetsProvider.budgetsProvider),
          emptyText: 'No budgets',
          builder: (context, index, data) => data.when(
            title: (isPinned) => Padding(
              padding:
                  index == 0 ? EdgeInsets.zero : const EdgeInsets.only(top: 8),
              child: TitleCard(
                title: '${isPinned ? 'Pinned' : 'Other'} '
                    'budget${isPinned ? '' : 's'}',
              ),
            ),
            value: (budget) => BudgetTile(budget: budget),
          ),
          lastChild: Padding(
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add budget',
        onPressed: () => Navigator.pushNamed(context, AddBudgetPage.route),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
