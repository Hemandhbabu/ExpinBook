import '../../core_package/core_widget.dart';

import '../add_transaction_provider.dart';
import '../../my_impl/custom_date_picker.dart';
import '../../../utils/base_extensions.dart';
import '../../../utils/my_datetime.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DateCard extends ConsumerWidget {
  const DateCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateTime = ref.watch(AddTransactionProvider.dateProvider);
    final editable = ref.watch(AddTransactionProvider.editableProvider);
    return AddEditInfoCard(
      title: 'Date',
      onTap: editable
          ? () => showCustomDatePicker(
                context: context,
                initialDate: dateTime,
                timeOfDay: TimeOfDay.fromDateTime(dateTime),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              ).then(
                (value) => value?.let(
                  (value) => ref
                      .read(AddTransactionProvider.dateProvider.notifier)
                      .update((state) => value),
                ),
              )
          : null,
      child: CustomTile(
        leadingIcon: Icons.today_rounded,
        padding: const EdgeInsets.only(top: 2, bottom: 5),
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        title: dateTime.dateOrMonthFormat(false, alwaysShowTime: true),
        titleSize: 18,
      ),
    );
  }
}
