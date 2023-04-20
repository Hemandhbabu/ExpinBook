import '../../../utils/type_def_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/category_filter_utils.dart';
import '../../utils/date_filter_utils.dart';
import '../../utils/payment_filter_utils.dart';
import '../../utils/show_action_utils.dart';
import '../transaction_overview_provider.dart';

class TransactionFilterButton extends ConsumerWidget {
  const TransactionFilterButton({super.key});

  static void showCustomFilter({
    required BuildContext context,
    required Reader read,
  }) {
    final date = read(TransactionOverviewProvider.dateFilterProvider);
    final category = read(TransactionOverviewProvider.categoryFilterProvider);
    final payment = read(TransactionOverviewProvider.paymentFilterProvider);
    showCustomAction(
      context,
      TileActionData(
        actions: [
          TileAction(
            icon: Icons.today_rounded,
            text: date.format,
            value: 0,
          ),
          TileAction(
            icon: Icons.category_rounded,
            text: category.format,
            value: 1,
          ),
          TileAction(
            icon: Icons.payments_rounded,
            text: payment.format,
            value: 2,
          ),
        ],
        valueChanged: (value) {
          if (value == 0) {
            showDateFilter(context, date).then(
              (value) {
                if (value != null) {
                  read(TransactionOverviewProvider.dateFilterProvider.notifier)
                      .state = value;
                }
              },
            );
          } else if (value == 1) {
            showCategoryFilter(context, category, true).then(
              (value) {
                if (value != null) {
                  read(TransactionOverviewProvider
                          .categoryFilterProvider.notifier)
                      .state = value;
                }
              },
            );
          } else if (value == 2) {
            showPaymentFilter(context, payment).then(
              (value) {
                if (value != null) {
                  read(TransactionOverviewProvider
                          .paymentFilterProvider.notifier)
                      .state = value;
                }
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () => showCustomFilter(context: context, read: ref.read),
      icon: const Icon(Icons.filter_alt_rounded),
    );
  }
}
