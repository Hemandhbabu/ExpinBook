import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/currency_text.dart';
import '../../core_package/core_widget.dart';

class AmountInfo extends ConsumerWidget {
  final double amount;
  const AmountInfo({super.key, required this.amount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AddEditInfoCard(
      title: 'Budget amount',
      child: CustomTile(
        leadingIcon: Icons.money_rounded,
        padding: const EdgeInsets.symmetric(vertical: 5),
        color: Colors.transparent,
        titleColor: Colors.green,
        margin: EdgeInsets.zero,
        title: ref.watch(currencyFormat(amount)),
        titleSize: 22,
      ),
    );
  }
}
