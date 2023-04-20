import '../../../utils/my_datetime.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core_package/core_widget.dart';

class DateInfo extends ConsumerWidget {
  final DateTime dateTime;
  const DateInfo({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AddEditInfoCard(
      title: 'Date',
      child: CustomTile(
        leadingIcon: Icons.today_rounded,
        padding: const EdgeInsets.only(top: 2, bottom: 5),
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        title: dateTime.dateOrMonthFormat(false, alwaysShowTime: true),
        titleSize: 20,
      ),
    );
  }
}
