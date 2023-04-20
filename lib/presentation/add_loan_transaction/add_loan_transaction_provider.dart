import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/loan_transaction.dart';
import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import '../../utils/snack_bar_data.dart';
import '../../utils/snack_bar_utils.dart';
import '../../utils/type_def_utils.dart';
import '../utils/dialog_utils.dart';

class AddLoanTransactionProvider {
  const AddLoanTransactionProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final editableProvider = StateProvider.autoDispose((ref) => true);

  static final dateProvider =
      StateProvider.autoDispose((ref) => DateTime.now());

  static final amountProvider = StateProvider.autoDispose((ref) => 0.0);

  static final loanProvider = StateProvider.autoDispose<int?>((ref) => null);

  static final isPayProvider = StateProvider.autoDispose((ref) => true);

  static final descriptionProvider = StateProvider.autoDispose((ref) => '');

  static final imagePathProvider =
      StateProvider.autoDispose<String?>((ref) => null);

  static final validatorProvider = Provider.autoDispose.family(validator);

  static bool validator(
      AutoDisposeProviderRef ref, LoanTransaction? transaction) {
    final amount = ref.watch(amountProvider);
    final description = ref.watch(descriptionProvider);
    final imagePath = ref.watch(imagePathProvider);
    final dateTime = ref.watch(dateProvider);
    final loan = ref.watch(loanProvider);
    final isPay = ref.watch(isPayProvider);
    final result = amount > 0 && loan != null;
    if (transaction == null) return result;
    if (result) {
      return LoanTransaction(
                id: transaction.id,
                amount: amount,
                isPay: isPay,
                description: description.let(
                  (value) => value.isNotEmpty ? value : null,
                ),
                loanId: loan,
                imagePath: imagePath,
                dateTime: dateTime,
              ) !=
              transaction &&
          result;
    } else {
      return false;
    }
  }

  static void save(BuildContext context, Reader read, int id) {
    final transaction = LoanTransaction(
      id: id > 0 ? id : null,
      amount: read(amountProvider),
      loanId: read(loanProvider) ?? 1,
      isPay: read(isPayProvider),
      description: read(descriptionProvider).let(
        (value) => value.isNotEmpty ? value : null,
      ),
      imagePath: read(imagePathProvider),
      dateTime: read(dateProvider),
    );
    final dao = read(loanTransactionUseCasesProvider);
    if (id > 0) {
      dao.modifyLoanTransaction.update(transaction).then(
        (value) {
          if (value) Navigator.pop(context);
          showSnackBar(
            SnackBarData(
              message: value
                  ? 'Loan transaction updated successfully'
                  : 'Error while updating transaction',
            ),
          );
        },
      );
    } else {
      dao.modifyLoanTransaction.add(transaction).then(
        (value) {
          if (value) Navigator.pop(context);
          showSnackBar(
            SnackBarData(
              message: value
                  ? 'Loan transaction added successfully'
                  : 'Error while adding transaction',
            ),
          );
        },
      );
    }
  }

  static Future<bool?> delete(
    BuildContext context,
    Reader read,
    LoanTransaction transaction,
  ) =>
      showCustomDialog(
        context: context,
        title: 'Are you sure ?',
        content: 'Do you want to delete this transaction ?',
        actionsBuilder: (context) => [
          CustomDialogAction(
            text: 'No',
            onTap: () => Navigator.pop(context),
          ),
          CustomDialogAction(
            text: 'Yes',
            onTap: () {
              Navigator.pop(context, true);
              read(loanTransactionUseCasesProvider)
                  .modifyLoanTransaction
                  .delete(transaction);
              showSnackBar(
                const SnackBarData(message: 'Transaction deleted'),
              );
            },
          ),
        ],
      );
}
