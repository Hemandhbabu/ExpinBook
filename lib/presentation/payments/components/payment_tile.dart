import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/payment.dart';
import '../../add_payment/add_payment_arg.dart';
import '../../add_payment/add_payment_page.dart';
import '../../add_payment/add_payment_provider.dart';
import '../../core_package/core_widget.dart';
import '../../utils/show_action_utils.dart';

class PaymentTile extends ConsumerWidget {
  final Payment payment;
  const PaymentTile({super.key, required this.payment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTile(
      maxLines: 1,
      leadingIcon: payment.mode.icon,
      leadingColor: payment.color,
      title: payment.name,
      subtitle: payment.description,
      padding: payment.description?.isNotEmpty != true
          ? const EdgeInsets.symmetric(vertical: 5)
          : EdgeInsets.zero,
      onTap: () => Navigator.pushNamed(
        context,
        AddPaymentPage.route,
        arguments: AddPaymentArg(payment: payment),
      ),
      onLongPress: payment.id == 1
          ? null
          : () => showCustomAction(
                context,
                tile: this,
                TileActionData(
                  actions: const [
                    TileAction(
                      icon: Icons.edit_rounded,
                      text: 'Edit payment',
                      iconColor: Colors.blue,
                      tileColor: Colors.blue,
                      value: 1,
                    ),
                    TileAction(
                      icon: Icons.delete_rounded,
                      text: 'Delete payment',
                      iconColor: Colors.red,
                      tileColor: Colors.red,
                      value: 2,
                    ),
                  ],
                  valueChanged: (value) {
                    if (value == 1) {
                      Navigator.pushNamed(
                        context,
                        AddPaymentPage.route,
                        arguments:
                            AddPaymentArg(editable: true, payment: payment),
                      );
                    } else if (value == 2) {
                      AddPaymentProvider.delete(context, ref.read, payment);
                    }
                  },
                ),
              ),
    );
  }
}
