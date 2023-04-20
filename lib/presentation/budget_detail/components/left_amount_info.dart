import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/currency_text.dart';
import '../../core_package/core_widget.dart';

class LeftAmountInfo extends ConsumerWidget {
  final double amount;
  const LeftAmountInfo({super.key, required this.amount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AddEditInfoCard(
      title: 'Budget ${amount < 0 ? 'exceeded by' : 'left to spend'}',
      child: CustomTile(
        leadingIcon: Icons.money_rounded,
        padding: const EdgeInsets.only(top: 2, bottom: 5),
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        titleColor: amount < 0 ? Colors.red : null,
        title: ref.watch(currencyFormat(amount < 0 ? -amount : amount)),
        titleSize: 20,
      ),
    );
  }
}
