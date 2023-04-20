import 'components/date_info.dart';
import 'components/interest_info.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../add_loan/add_loan_arg.dart';
import '../add_loan/add_loan_page.dart';
import '../core_package/core_widget.dart';
import '../loan_transactions/components/loan_transaction_tile.dart';
import '../loan_transactions/loan_transactions_page.dart';
import 'components/amount_info.dart';
import 'components/description_info.dart';
import 'components/left_amount_info.dart';
import 'components/paid_amount_info.dart';
import 'loan_detail_provider.dart';

class LoanDetailPage extends ConsumerWidget {
  static const route = 'loan-detail-page';
  final int id;
  const LoanDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncWidgetWrapper(
      asyncValue: ref.watch(LoanDetailProvider.loanDetailProvider(id)),
      nullBuilder: (context) {
        Future.delayed(Duration.zero, () => Navigator.pop(context));
        return const CenterText('An error occured');
      },
      loadingBuilder: (context) => const LoadingList(),
      builder: (context, detail) => Scaffold(
        appBar: CustomAppBar.elevated(
          provider: LoanDetailProvider.elevatedProvider,
          title: detail.loan.name,
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                AddLoanPage.route,
                arguments: AddLoanArg(loan: detail.loan),
              ),
              icon: const Icon(Icons.edit_rounded),
            ),
          ],
        ),
        body: ScrollNotificationWrapper(
          provider: LoanDetailProvider.elevatedProvider,
          child: ListView(
            children: [
              DateInfo(dateTime: detail.loan.dateTime),
              const SizedBox(height: 8),
              AmountInfo(amount: detail.totalLoan),
              const SizedBox(height: 8),
              InterestInfo(interest: detail.loan.interest),
              const SizedBox(height: 8),
              PaidAmountInfo(amount: detail.paidAmount),
              const SizedBox(height: 8),
              LeftAmountInfo(amount: detail.leftToPay),
              const SizedBox(height: 8),
              DescriptionInfo(description: detail.loan.description),
              const SizedBox(height: 4),
              TitleCard(
                title: 'Transactions',
                trailing: TextButton(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    LoanTransactionsPage.route,
                    arguments: detail.loan,
                  ),
                  child: const Text('See all'),
                ),
              ),
              if (detail.transactions.isEmpty)
                const AspectRatio(
                  aspectRatio: 1.75,
                  child: CenterText('No transactions'),
                ),
              ...detail.transactions.take(5).map(
                    (transaction) => LoanTransactionTile(
                      loan: detail.loan,
                      transaction: transaction,
                    ),
                  ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
