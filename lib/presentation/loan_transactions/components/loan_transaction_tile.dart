import '../../../provider/use_cases_provider.dart';
import '../../../utils/my_datetime.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/loan.dart';
import '../../../domain/models/loan_transaction.dart';
import '../../../utils/type_def_utils.dart';
import '../../add_loan_transaction/add_loan_transaction_arg.dart';
import '../../add_loan_transaction/add_loan_transaction_page.dart';
import '../../add_loan_transaction/add_loan_transaction_provider.dart';
import '../../core/currency_text.dart';
import '../../core_package/core_widget.dart';
import '../../my_impl/custom_date_picker.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/show_action_utils.dart';

class LoanTransactionTile extends ConsumerWidget {
  final Loan loan;
  final LoanTransaction transaction;
  final bool showTimeOnly;
  const LoanTransactionTile({
    super.key,
    required this.loan,
    required this.transaction,
    this.showTimeOnly = false,
  });

  String format(DateTime date) {
    final timeFormat = DateFormat('hh:mm a').format;
    if (showTimeOnly) return timeFormat(date);
    final now = DateTime.now();
    final format = DateFormat.yMd().format;
    if (format(now) == format(date)) {
      return timeFormat(date);
    } else if (format(now.subtract(const Duration(days: 1))) == format(date)) {
      return 'Yesterday';
    } else {
      return date.dateOrMonthFormat(false, alsoWeek: true);
    }
  }

  void onTap(BuildContext context) => Navigator.pushNamed(
        context,
        AddLoanTransactionPage.route,
        arguments: AddLoanTransactionArg(
          transaction: transaction,
          loanId: transaction.loanId,
        ),
      );

  void showLongPress(BuildContext context, Reader read) => showCustomAction(
        context,
        tile: this,
        TileActionData(
          actions: const [
            TileAction(
              icon: Icons.copy_rounded,
              text: 'Copy transaction',
              value: 0,
            ),
            TileAction(
              icon: Icons.edit_rounded,
              text: 'Edit transaction',
              iconColor: Colors.blue,
              tileColor: Colors.blue,
              value: 1,
            ),
            TileAction(
              icon: Icons.delete_rounded,
              text: 'Delete transaction',
              iconColor: Colors.red,
              tileColor: Colors.red,
              value: 2,
            ),
          ],
          valueChanged: (value) {
            if (value == 0) {
              showDuplicateSheet(context, read);
            } else if (value == 1) {
              Navigator.pushNamed(
                context,
                AddLoanTransactionPage.route,
                arguments: AddLoanTransactionArg(
                  editable: true,
                  transaction: transaction,
                  loanId: transaction.loanId,
                ),
              );
            } else if (value == 2) {
              AddLoanTransactionProvider.delete(context, read, transaction);
            }
          },
        ),
      );

  void showDuplicateSheet(BuildContext context, Reader read) =>
      showCustomDialog(
        context: context,
        title: 'Copy transaction',
        content:
            'Do you want to make a copy of the transaction with same date ?',
        actionsBuilder: (context) => [
          CustomDialogAction(
            text: 'Copy transaction',
            onTap: () {
              Navigator.pop(context);
              read(loanTransactionUseCasesProvider).modifyLoanTransaction.add(
                    transaction.copyWith(
                      id: -1,
                      dateTime:
                          transaction.dateTime.copyTimeOfDay(TimeOfDay.now()),
                    ),
                  );
            },
          ),
          CustomDialogAction(
            text: 'Pick date',
            onTap: () async {
              Navigator.pop(context);
              final picked = await showCustomDatePicker(
                context: context,
                initialDate: transaction.dateTime,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                confirmText: 'Pick date',
                timeOfDay: TimeOfDay.fromDateTime(transaction.dateTime),
              );
              if (picked != null) {
                await read(loanTransactionUseCasesProvider)
                    .modifyLoanTransaction
                    .add(transaction.copyWith(id: -1, dateTime: picked));
              }
            },
          ),
          CustomDialogAction(
            text: 'Cancel',
            onTap: () => Navigator.pop(context),
          ),
        ],
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTile(
      maxLines: 1,
      onTap: () => onTap(context),
      onLongPress: () => showLongPress(context, ref.read),
      leadingIcon: loan.icon,
      leadingSymbol: loan.symbol,
      leadingColor: loan.color,
      title: loan.name,
      subtitle: format(transaction.dateTime),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CurrencyText(
            transaction.amount,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: transaction.isPay ? null : Colors.red,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (transaction.description?.isNotEmpty == true)
                const Icon(Icons.notes_rounded, size: 14.5),
              if (transaction.imagePath != null)
                const Icon(Icons.attach_file_rounded, size: 12.5),
            ],
          ),
        ],
      ),
    );
  }
}
