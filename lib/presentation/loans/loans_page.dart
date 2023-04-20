import 'package:flutter/material.dart';

import '../add_loan/add_loan_page.dart';
import '../core_package/core_widget.dart';
import 'components/loan_tile.dart';
import 'loans_provider.dart';

class LoansPage extends StatelessWidget {
  static const route = 'loans-page';
  const LoansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: LoansProvider.elevatedProvider,
        title: 'Loans',
        actions: [
          IconButton(
            tooltip: 'Add loan',
            onPressed: () => Navigator.pushNamed(context, AddLoanPage.route),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: ScrollNotificationWrapper(
        provider: LoansProvider.elevatedProvider,
        builder: (context, ref, child) => CustomListView.async(
          firstChild: const SizedBox(height: 8),
          hasFab: true,
          asyncValue: ref.watch(LoansProvider.loansProvider),
          emptyText: 'No loans',
          builder: (context, index, loan) => LoanTile(loan: loan),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add loan',
        onPressed: () => Navigator.pushNamed(context, AddLoanPage.route),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
