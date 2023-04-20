import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/filter_item.dart';
import '../../utils/date_filter_utils.dart';
import '../../utils/payment_filter_utils.dart';
import '../payment_overview_provider.dart';

class PaymentOverviewFilterBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const PaymentOverviewFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(PaymentOverviewProvider.dateFilterProvider);
    final payment = ref.watch(PaymentOverviewProvider.paymentFilterProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterItem(
            dense: true,
            text: date.format,
            onTap: () => showDateFilter(context, date).then(
              (value) {
                if (value != null) {
                  ref
                      .read(PaymentOverviewProvider.dateFilterProvider.notifier)
                      .state = value;
                }
              },
            ),
          ),
          FilterItem(
            dense: true,
            text: payment.format,
            onTap: () => showPaymentFilter(context, payment).then((value) {
              if (value != null) {
                ref
                    .read(
                        PaymentOverviewProvider.paymentFilterProvider.notifier)
                    .state = value;
              }
            }),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(46);
}
