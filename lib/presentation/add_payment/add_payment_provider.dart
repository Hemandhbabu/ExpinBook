import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/payment.dart';
import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import '../../utils/category_data.dart';
import '../../utils/snack_bar_data.dart';
import '../../utils/snack_bar_utils.dart';
import '../../utils/type_def_utils.dart';
import '../utils/dialog_utils.dart';

class AddPaymentProvider {
  const AddPaymentProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final editableProvider = StateProvider.autoDispose((ref) => true);

  static final nameProvider = StateProvider.autoDispose((ref) => '');

  static final modeProvider =
      StateProvider.autoDispose((ref) => PaymentMode.card);

  static final descriptionProvider = StateProvider.autoDispose((ref) => '');

  static final colorProvider = StateProvider.autoDispose(
      (ref) => categoryColors[Random().nextInt(categoryColors.length)]);

  static final validatorProvider = Provider.autoDispose.family(validator);

  static bool validator(AutoDisposeProviderRef ref, Payment? payment) {
    final name = ref.watch(nameProvider);
    final mode = ref.watch(modeProvider);
    final description = ref.watch(descriptionProvider);
    final color = ref.watch(colorProvider);
    final result = name.isNotEmpty;
    if (payment == null) return result;
    if (result) {
      return Payment(
            id: payment.id,
            name: name,
            mode: mode,
            color: color,
            description:
                description.let((value) => value.isEmpty ? null : value),
          ) !=
          payment;
    } else {
      return false;
    }
  }

  static void save(BuildContext context, Reader read, int id) {
    final payment = Payment(
      id: id > 0 ? id : null,
      name: read(nameProvider),
      mode: read(modeProvider),
      color: read(colorProvider),
      description: read(descriptionProvider)
          .let((value) => value.isEmpty ? null : value),
    );
    final dao = read(paymentUseCasesProvider);
    if (id > 0) {
      dao.modifyPayment.update(payment).then(
        (value) {
          if (value) Navigator.pop(context);
          showSnackBar(
            SnackBarData(
              message: value
                  ? 'Payment updated successfully'
                  : 'Error while updating payment',
            ),
          );
        },
      );
    } else {
      dao.modifyPayment.add(payment).then(
        (value) {
          if (value) Navigator.pop(context);
          showSnackBar(
            SnackBarData(
              message: value
                  ? 'Payment added successfully'
                  : 'Error while adding payment',
            ),
          );
        },
      );
    }
  }

  static Future<bool?> delete(
          BuildContext context, Reader read, Payment payment) =>
      showCustomDialog(
        context: context,
        title: 'Are you sure ?',
        content: 'Do you want to delete this payment ?\n\nNote :\n'
            'Deleting this payment will modify the transaction with this payment to "Cash"',
        actionsBuilder: (context) => [
          CustomDialogAction(
            text: 'No',
            onTap: () => Navigator.pop(context),
          ),
          CustomDialogAction(
            text: 'Yes',
            onTap: () {
              Navigator.pop(context, true);
              read(paymentUseCasesProvider).modifyPayment.delete(payment);
              showSnackBar(const SnackBarData(message: 'Payment deleted'));
            },
          ),
        ],
      );
}
