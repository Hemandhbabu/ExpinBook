import '../core_package/core_widget.dart';
import '../loans/loans_page.dart';
import 'components/theme_card.dart';

import '../categories/categories_page.dart';
import '../payments/payments_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../all_transactions/all_transactions_page.dart';
import '../budgets/budgets_page.dart';
import '../category_overview/category_overview_page.dart';
import '../transaction_overview/transaction_overview_page.dart';
import '../payment_overview/payment_overview_page.dart';
import '../pinned_categories/pinned_categories_page.dart';
import '../settings/settings_page.dart';
import 'components/dashboard_tile.dart';
import 'components/dashboard_title.dart';

final _elevatedProvider = StateProvider.autoDispose((ref) => false);

class DashboardPage extends StatelessWidget {
  static const route = 'dashboard-page';
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.elevated(
        title: 'Dashboard',
        leading: const CustomCloseButton(),
        provider: _elevatedProvider,
        actions: [
          const ThemeIcon(),
          IconButton(
            tooltip: 'Settings',
            onPressed: () =>
                Navigator.popAndPushNamed(context, SettingsPage.route),
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: ScrollNotificationWrapper(
        provider: _elevatedProvider,
        child: ListView(
          children: [
            const DashboardTitle(title: 'Components'),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              children: const [
                DashboardTile(
                  icon: Icons.list_alt_rounded,
                  title: 'Transactions',
                  routeName: AllTransactionsPage.route,
                ),
                DashboardTile(
                  icon: Icons.category_rounded,
                  title: 'Categories',
                  routeName: CategoriesPage.route,
                ),
                DashboardTile(
                  icon: Icons.payments_rounded,
                  title: 'Payments',
                  routeName: PaymentsPage.route,
                ),
                DashboardTile(
                  icon: Icons.receipt_long_rounded,
                  title: 'Budgets',
                  routeName: BudgetsPage.route,
                ),
                DashboardTile(
                  icon: Icons.assignment_rounded,
                  title: 'Loans',
                  routeName: LoansPage.route,
                ),
              ],
            ),
            const DashboardTitle(title: 'Analysis'),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.25,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              children: const [
                DashboardTile(
                  icon: Icons.push_pin_rounded,
                  small: 'Pinned',
                  title: 'categories',
                  routeName: PinnedCategoriesPage.route,
                ),
                DashboardTile(
                  icon: Icons.event_note_rounded,
                  small: 'Transactions',
                  title: 'overview',
                  routeName: TransactionOverviewPage.route,
                ),
                DashboardTile(
                  icon: Icons.extension_rounded,
                  small: 'Categories',
                  title: 'overview',
                  routeName: CategoryOverviewPage.route,
                ),
                DashboardTile(
                  icon: Icons.payment_rounded,
                  small: 'Payments',
                  title: 'overview',
                  routeName: PaymentOverviewPage.route,
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
