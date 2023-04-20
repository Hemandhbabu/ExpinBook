import '../../utils/payment_filter.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/type_def_utils.dart';
import '../../utils/date_filter_utils.dart';
import '../../utils/payment_filter_utils.dart';
import '../../utils/show_action_utils.dart';
import '../payment_overview_provider.dart';

class PaymentOverviewFilterButton extends ConsumerWidget {
  const PaymentOverviewFilterButton({super.key});

  static void selectPayment({
    required BuildContext context,
    required PaymentFilter payment,
    required Reader read,
  }) =>
      showPaymentFilter(context, payment).then(
        (value) {
          if (value != null) {
            read(PaymentOverviewProvider.paymentFilterProvider.notifier).state =
                value;
          }
        },
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(PaymentOverviewProvider.dateFilterProvider);
    final payment = ref.watch(PaymentOverviewProvider.paymentFilterProvider);
    return IconButton(
      onPressed: () => showCustomAction(
        context,
        TileActionData(
          actions: [
            TileAction(
              icon: Icons.today_rounded,
              text: date.format,
              value: 0,
            ),
            TileAction(
              icon: Icons.payments_rounded,
              text: payment.format,
              value: 1,
            ),
          ],
          valueChanged: (value) {
            if (value == 0) {
              showDateFilter(context, date).then(
                (value) {
                  if (value != null) {
                    ref
                        .read(
                            PaymentOverviewProvider.dateFilterProvider.notifier)
                        .state = value;
                  }
                },
              );
            } else if (value == 1) {
              selectPayment(context: context, payment: payment, read: ref.read);
            }
          },
        ),
      ),
      icon: const Icon(Icons.filter_alt_rounded),
    );
  }
}
