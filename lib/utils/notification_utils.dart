// ignore_for_file: constant_identifier_names

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest_all.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

import '../provider/preferences_provider.dart';
import 'native_utils.dart';

final _plugin = FlutterLocalNotificationsPlugin();

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final timeZoneName = await NativeUtils.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

Future<void> initializeNotification() async {
  await _configureLocalTimeZone();
  await _plugin.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('ic_logo_notification'),
    ),
  );
}

final setNotificationProvider = FutureProvider.autoDispose(
  (ref) async {
    final hasNotification = ref.watch(hasDailyNotificationPreferencesProvider);
    final time = DateTime.parse(
      ref.watch(dailyNotificationTimePreferencesProvider),
    );
    if (hasNotification) {
      await _setDailyNotification(time.hour, time.minute, _plugin);
      return true;
    } else {
      await _cancelDailyNotification(_plugin);
      return false;
    }
  },
);

const _DAILY_NOTIFICATION_ID = 546;
const _DAILY_NOTIFICATION_CHANNEL_ID = "Daily-Reminder";

Future<void> _setDailyNotification(
  int hour,
  int minute,
  FlutterLocalNotificationsPlugin plugin,
) =>
    _buildRepeatingNotification(
      id: _DAILY_NOTIFICATION_ID,
      hour: hour,
      minute: minute,
      title: 'Reminder',
      content: 'Don\'t forgot to add your daily transactions',
      bigText:
          'Don\'t forgot to add your daily transactions to manage your budget on track',
      channelId: _DAILY_NOTIFICATION_CHANNEL_ID,
      channelName: 'Daily reminder',
      dateTimeComponents: DateTimeComponents.time,
      plugin: plugin,
    );

Future<void> _buildRepeatingNotification({
  required int id,
  required int hour,
  required int minute,
  required String title,
  required String content,
  String? bigText,
  required String channelId,
  required String channelName,
  String? channelDescription,
  required DateTimeComponents dateTimeComponents,
  String? payload,
  required FlutterLocalNotificationsPlugin plugin,
}) async {
  final bigTextStyleInformation = bigText == null
      ? null
      : BigTextStyleInformation(bigText, contentTitle: title);
  final platformChannelSpecifics = NotificationDetails(
    android: AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      styleInformation: bigTextStyleInformation,
      importance: Importance.max,
      priority: Priority.high,
    ),
  );
  await plugin.zonedSchedule(
    id,
    title,
    content,
    _nextInstanceOfTime(hour, minute),
    platformChannelSpecifics,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: dateTimeComponents,
    payload: payload,
  );
}

tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute, 0);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

Future<void> _cancelDailyNotification(FlutterLocalNotificationsPlugin plugin) =>
    plugin.cancel(_DAILY_NOTIFICATION_ID);
