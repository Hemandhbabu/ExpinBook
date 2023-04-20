import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core_package/core_widget.dart';

class InterestInfo extends ConsumerWidget {
  final double interest;
  const InterestInfo({super.key, required this.interest});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AddEditInfoCard(
      title: 'Loan interest',
      child: CustomTile(
        leadingIcon: Icons.percent_rounded,
        padding: const EdgeInsets.only(top: 2, bottom: 5),
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        title:
            '${interest % 1 == 0 ? interest.toInt() : interest.toStringAsFixed(2)} %',
        titleSize: 20,
      ),
    );
  }
}
