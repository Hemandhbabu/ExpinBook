import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/currency_text.dart';
import '../../core_package/core_widget.dart';

class PaidAmountInfo extends ConsumerWidget {
  final double amount;
  const PaidAmountInfo({super.key, required this.amount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AddEditInfoCard(
      title: 'Loan paid',
      child: CustomTile(
        leadingIcon: Icons.money_rounded,
        padding: const EdgeInsets.only(top: 2, bottom: 5),
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        title: ref.watch(currencyFormat(amount < 0 ? -amount : amount)),
        titleSize: 20,
      ),
    );
  }
}
