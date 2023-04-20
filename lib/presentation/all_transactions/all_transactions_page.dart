import '../core_package/core_widget.dart';
import '../search_transaction/search_transaction_page.dart';
import 'package:flutter/material.dart';

import '../add_transaction/add_transaction_page.dart';
import '../core/expin_list_view.dart';
import 'all_transactions_provider.dart';

class AllTransactionsPage extends StatelessWidget {
  static const route = 'all-transactions-page';
  const AllTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: AllTransactionsProvider.elevatedProvider,
        title: 'Transactions',
        actions: [
          IconButton(
            tooltip: 'Search',
            onPressed: () =>
                Navigator.pushNamed(context, SearchTransactionPage.route),
            icon: const Icon(Icons.search_rounded),
          ),
          IconButton(
            tooltip: 'Add transaction',
            onPressed: () =>
                Navigator.pushNamed(context, AddTransactionPage.route),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: ScrollNotificationWrapper(
        provider: AllTransactionsProvider.elevatedProvider,
        child: ExpinListView(
          hasFab: true,
          provider: AllTransactionsProvider.allTransactionsProvider,
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
