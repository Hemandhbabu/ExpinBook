import '../budgets/budgets_page.dart';
import '../budgets/components/budget_tile.dart';
import '../../utils/base_extensions.dart';

import '../core_package/core_widget.dart';
import '../dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';

import '../../provider/preferences_provider.dart';
import '../../utils/my_datetime.dart';
import '../add_transaction/add_transaction_page.dart';
import '../all_transactions/all_transactions_page.dart';
import '../category_overview/category_overview_page.dart';
import '../core/category_transactions_tile.dart';
import '../core/income_expense_card.dart';
import '../core/shortcut_card.dart';
import '../core/transaction_tile.dart';
import '../payment_overview/payment_overview_page.dart';
import '../pinned_categories/pinned_categories_page.dart';
import '../utils/date_filter.dart';
import 'home_provider.dart';

class HomePage extends StatelessWidget {
  static const route = 'home-page';
  const HomePage({super.key});

  String get greeting {
    final hour = DateTime.now().hour;
    if (hour >= 22) return 'night';
    if (hour >= 16) return 'evening';
    if (hour >= 12) return 'afternoon';
    if (hour >= 4) return 'morning';
    return 'night';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: HomeProvider.elevatedProvider,
        title: 'Home',
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, DashboardPage.route),
          icon: const Icon(Icons.menu_rounded),
        ),
        actions: [
          IconButton(
            tooltip: 'Add transaction',
            onPressed: () =>
                Navigator.pushNamed(context, AddTransactionPage.route),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: ScrollNotificationWrapper(
        provider: HomeProvider.elevatedProvider,
        builder: (context, ref, child) => AsyncWidgetWrapper(
          asyncValue: ref.watch(HomeProvider.homeDataProvider),
          loadingBuilder: (context) => const LoadingList(),
          builder: (context, data) => ListView(
            padding: const EdgeInsets.only(top: 10, bottom: 80),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Opacity(
                            opacity: 0.75,
                            child: Text(
                              'Good $greeting,',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          FittedBox(
                            child: Text(
                              ref.watch(usernamePreferencesProvider),
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          now.format('MMMM'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${now.year}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ],
                ),
              ),
              IncomeExpenseCard(
                showSavings: true,
                expins: HomeProvider.homeExpinsProvider,
                filter: DateFilter.month(DateTime.now()),
              ),
              TitleCard(
                title: 'Transactions',
                trailing: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, AllTransactionsPage.route),
                  child: const Text('See all'),
                ),
              ),
              data.expins.isEmpty
                  ? const AspectRatio(
                      aspectRatio: 1.75,
                      child: CenterText('No transactions'),
                    )
                  : Column(
                      children: data.expins
                          .map((e) => TransactionTile(expinData: e))
                          .toList(),
                    ),
              const SizedBox(height: 16),
              TitleCard(
                title: 'Pinned categories',
                trailing: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, PinnedCategoriesPage.route),
                  child: const Text('See all'),
                ),
              ),
              data.pinnedCategories.isEmpty
                  ? const AspectRatio(
                      aspectRatio: 1.75,
                      child: CenterText('No pinned categories'),
                    )
                  : Column(
                      children: data.pinnedCategories
                          .map((e) => CategoryTransactionsTile(categoryData: e))
                          .toList(),
                    ),
              const SizedBox(height: 16),
              TitleCard(
                title: 'Budget',
                trailing: TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, BudgetsPage.route),
                  child: const Text('See all'),
                ),
              ),
              data.budget?.let((value) => BudgetTile(budget: value)) ??
                  const AspectRatio(
                    aspectRatio: 1.75,
                    child: CenterText('No budgets'),
                  ),
              const SizedBox(height: 16),
              const ShortcutCard(
                data: [
                  ShortcutData(
                    left: ShortcutGridData(
                      firstName: 'Categories',
                      lastName: 'overview',
                      message: 'Track categories in a given range.',
                      destination: CategoryOverviewPage.route,
                    ),
                    right: ShortcutGridData(
                      firstName: 'Payments',
                      lastName: 'overview',
                      message: 'Track payments in a given range.',
                      destination: PaymentOverviewPage.route,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add transaction',
        onPressed: () => Navigator.pushNamed(context, AddTransactionPage.route),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
