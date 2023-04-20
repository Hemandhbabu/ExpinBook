import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/expin.dart';
import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import '../../utils/snack_bar_data.dart';
import '../../utils/snack_bar_utils.dart';
import '../../utils/type_def_utils.dart';
import '../utils/dialog_utils.dart';

class AddTransactionProvider {
  const AddTransactionProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final editableProvider = StateProvider.autoDispose((ref) => true);

  static final dateProvider =
      StateProvider.autoDispose((ref) => DateTime.now());

  static final amountProvider = StateProvider.autoDispose((ref) => 0.0);

  static final typeProvider =
      StateProvider.autoDispose((ref) => TransactionType.expense);

  static final categoryProvider = StateProvider.autoDispose((ref) => 6);

  static final paymentProvider = StateProvider.autoDispose((ref) => 1);

  static final toPaymentProvider =
      StateProvider.autoDispose<int?>((ref) => null);

  static final descriptionProvider = StateProvider.autoDispose((ref) => '');

  static final imagePathProvider =
      StateProvider.autoDispose<String?>((ref) => null);

  static final validatorProvider = Provider.autoDispose.family(validator);

  static bool validator(AutoDisposeProviderRef ref, Expin? expin) {
    final amount = ref.watch(amountProvider);
    final category = ref.watch(categoryProvider);
    final payment = ref.watch(paymentProvider);
    final toPayment = ref.watch(toPaymentProvider);
    final type = ref.watch(typeProvider);
    final description = ref.watch(descriptionProvider);
    final imagePath = ref.watch(imagePathProvider);
    final dateTime = ref.watch(dateProvider);
    if (payment == toPayment) return false;
    final result = amount > 0;
    if (expin == null) return result;
    if (result) {
      return Expin(
                id: expin.id,
                amount: amount,
                type: type,
                categoryId: category,
                paymentId: payment,
                toPaymentId: toPayment,
                description: description.let(
                  (value) => value.isNotEmpty ? value : null,
                ),
                imagePath: imagePath,
                dateTime: dateTime,
              ) !=
              expin &&
          result;
    } else {
      return false;
    }
  }

  static void save(BuildContext context, Reader read, int id) {
    final expin = Expin(
      id: id > 0 ? id : null,
      amount: read(amountProvider),
      type: read(typeProvider),
      categoryId: read(categoryProvider),
      paymentId: read(paymentProvider),
      toPaymentId: read(toPaymentProvider),
      description: read(descriptionProvider).let(
        (value) => value.isNotEmpty ? value : null,
      ),
      imagePath: read(imagePathProvider),
      dateTime: read(dateProvider),
    );
    final dao = read(expinUseCasesProvider);
    if (id > 0) {
      dao.modifyExpin.update(expin).then(
        (value) {
          if (value) Navigator.pop(context);
          showSnackBar(
            SnackBarData(
              message: value
                  ? 'Transaction updated successfully'
                  : 'Error while updating transaction',
            ),
          );
        },
      );
    } else {
      dao.modifyExpin.add(expin).then(
        (value) {
          if (value) Navigator.pop(context);
          showSnackBar(
            SnackBarData(
              message: value
                  ? 'Transaction added successfully'
                  : 'Error while adding transaction',
            ),
          );
        },
      );
    }
  }

  static Future<bool?> delete(BuildContext context, Reader read, Expin expin) =>
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
              read(expinUseCasesProvider).modifyExpin.delete(expin);
              showSnackBar(
                const SnackBarData(message: 'Transaction deleted'),
              );
            },
          ),
        ],
      );
}
