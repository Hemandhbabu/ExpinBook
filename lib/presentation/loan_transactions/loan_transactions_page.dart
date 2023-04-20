import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/loan.dart';
import '../../utils/my_datetime.dart';
import '../add_loan_transaction/add_loan_transaction_arg.dart';
import '../add_loan_transaction/add_loan_transaction_page.dart';
import '../core_package/core_widget.dart';
import 'components/loan_transaction_tile.dart';
import 'loan_transactions_provider.dart';

class LoanTransactionsPage extends ConsumerWidget {
  static const route = 'loan-transactions-page';
  final Loan loan;
  const LoanTransactionsPage({super.key, required this.loan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: LoanTransactionsProvider.elevatedProvider,
        title: 'Loan transactions',
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              AddLoanTransactionPage.route,
              arguments: AddLoanTransactionArg(loanId: loan.id!),
            ),
            tooltip: 'Add loan transaction',
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: CustomListView.async(
        hasFab: true,
        asyncValue: ref.watch(
          LoanTransactionsProvider.loanTransactionsProvider(loan.id!),
        ),
        emptyText: 'No transactions in "${loan.name}"',
        builder: (context, index, transaction) => transaction.when(
          date: (date, count) => Padding(
            padding:
                index == 0 ? EdgeInsets.zero : const EdgeInsets.only(top: 8),
            child: TitleCard(
              title: date.dateOrMonthFormat(false, alsoWeek: true),
            ),
          ),
          data: (transaction) => LoanTransactionTile(
            showTimeOnly: true,
            loan: loan,
            transaction: transaction,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          AddLoanTransactionPage.route,
          arguments: AddLoanTransactionArg(loanId: loan.id!),
        ),
        tooltip: 'Add loan transaction',
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
