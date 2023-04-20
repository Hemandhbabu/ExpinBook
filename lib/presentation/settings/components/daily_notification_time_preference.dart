import '../../core_package/core_widget.dart';
import '../../../provider/preferences_provider.dart';
import '../../../utils/base_extensions.dart';
import '../../../utils/my_datetime.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DailyNotificationTimePreference extends ConsumerWidget {
  const DailyNotificationTimePreference({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedCrossFade(
      firstChild: const SizedBox.shrink(),
      secondChild: () {
        final dateTime =
            DateTime.parse(ref.watch(dailyNotificationTimePreferencesProvider));
        return CustomTile(
          title: 'Reminder time',
          margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          padding: const EdgeInsets.symmetric(vertical: 5),
          trailing: Text(
            dateTime.timeFormat(),
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          onTap: () => showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(dateTime),
          ).then(
            (value) => value?.let(
              (value) => ref
                  .read(dailyNotificationTimePreferencesProvider.notifier)
                  .setString(dateTime.copyTimeOfDay(value).toIso8601String()),
            ),
          ),
        );
      }(),
      crossFadeState: ref.watch(hasDailyNotificationPreferencesProvider)
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
}
