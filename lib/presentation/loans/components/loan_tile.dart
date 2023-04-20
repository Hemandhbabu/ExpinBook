import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/theme.dart';
import '../../add_loan/add_loan_arg.dart';
import '../../add_loan/add_loan_page.dart';
import '../../add_loan/add_loan_provider.dart';
import '../../core/currency_text.dart';
import '../../core/custom_progress.dart';
import '../../core_package/custom_tile.dart';
import '../../loan_detail/loan_detail_data.dart';
import '../../loan_detail/loan_detail_page.dart';
import '../../utils/show_action_utils.dart';

class LoanTile extends ConsumerWidget {
  final LoanDetailData loan;
  const LoanTile({super.key, required this.loan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loanData = this.loan;
    final loan = loanData.loan;
    final loanAmount = loanData.totalLoan;
    final leftToPay = loanData.leftToPay;
    final paidAmount = loanData.paidAmount;
    final paidPercent = loanAmount > 0 ? paidAmount / loanAmount : 0.0;
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () => Navigator.pushNamed(
          context,
          LoanDetailPage.route,
          arguments: loan.id,
        ),
        onLongPress: () => showCustomAction(
          context,
          tile: this,
          TileActionData(
            actions: [
              const TileAction(
                icon: Icons.edit_rounded,
                text: 'Edit loan',
                iconColor: Colors.blue,
                tileColor: Colors.blue,
                value: 1,
              ),
              const TileAction(
                icon: Icons.delete_rounded,
                text: 'Delete loan',
                iconColor: Colors.red,
                tileColor: Colors.red,
                value: 2,
              ),
            ],
            valueChanged: (value) {
              if (value == 1) {
                Navigator.pushNamed(
                  context,
                  AddLoanPage.route,
                  arguments: AddLoanArg(loan: loan),
                );
              } else if (value == 2) {
                AddLoanProvider.delete(context, ref.read, loan);
              }
            },
          ),
        ),
        child: Column(
          children: [
            CustomTile(
              maxLines: 1,
              padding: loan.description?.isNotEmpty != true
                  ? const EdgeInsets.symmetric(vertical: 5)
                  : EdgeInsets.zero,
              leadingIcon: loan.icon,
              leadingSymbol: loan.symbol,
              leadingColor: loan.color,
              title: loan.name,
              subtitle: loan.description,
              color: Colors.transparent,
              trailing: CurrencyText(
                loanAmount,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 4),
            Column(
              children: [
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 28),
                  title: const Text(
                    'Loan left to pay',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: CurrencyText(
                    leftToPay,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: CustomLinearProgress(
                    value: paidPercent,
                    minHeight: 12,
                    color: ProgressColor.getColor(1 - paidPercent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
