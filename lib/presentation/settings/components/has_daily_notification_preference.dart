import '../../core_package/core_widget.dart';
import '../../utils/dialog_utils.dart';
import '../../../provider/preferences_provider.dart';
import '../../../utils/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HasDailyNotificationPreference extends ConsumerWidget {
  const HasDailyNotificationPreference({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasNotification = ref.watch(hasDailyNotificationPreferencesProvider);
    ref.listen(
      setNotificationProvider,
      (previous, next) => debugPrint('notification status $next'),
    );
    return CustomTile(
      title: 'Daily reminder',
      padding: const EdgeInsets.symmetric(vertical: 5),
      trailing: IgnorePointer(
        child: Switch(
          value: hasNotification,
          onChanged: (value) {},
        ),
      ),
      onTap: () async {
        final canChange = hasNotification
            ? await showCustomDialog<bool>(
                  context: context,
                  title: 'Are you sure ?',
                  content: 'Do you want to turn off your daily reminder ?',
                  actionsBuilder: (context) => [
                    CustomDialogAction(
                      onTap: () => Navigator.pop(context, false),
                      text: 'No',
                    ),
                    CustomDialogAction(
                      onTap: () => Navigator.pop(context, true),
                      text: 'Yes',
                    ),
                  ],
                ) ??
                false
            : true;
        if (canChange) {
          ref
              .read(hasDailyNotificationPreferencesProvider.notifier)
              .setBool(!hasNotification);
        }
      },
    );
  }
}
