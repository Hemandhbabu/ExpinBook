import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/filter_item.dart';
import '../../utils/category_filter_utils.dart';
import '../../utils/date_filter_utils.dart';
import '../../utils/payment_filter_utils.dart';
import '../transaction_overview_provider.dart';

class TransactionFilterBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const TransactionFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(TransactionOverviewProvider.dateFilterProvider);
    final category =
        ref.watch(TransactionOverviewProvider.categoryFilterProvider);
    final payment =
        ref.watch(TransactionOverviewProvider.paymentFilterProvider);
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
                      .read(TransactionOverviewProvider
                          .dateFilterProvider.notifier)
                      .state = value;
                }
              },
            ),
          ),
          FilterItem(
            dense: true,
            text: category.format,
            onTap: () => showCategoryFilter(context, category, true).then(
              (value) {
                if (value != null) {
                  ref
                      .read(TransactionOverviewProvider
                          .categoryFilterProvider.notifier)
                      .state = value;
                }
              },
            ),
          ),
          FilterItem(
            dense: true,
            text: payment.format,
            onTap: () => showPaymentFilter(context, payment).then(
              (value) {
                if (value != null) {
                  ref
                      .read(TransactionOverviewProvider
                          .paymentFilterProvider.notifier)
                      .state = value;
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(46);
}
