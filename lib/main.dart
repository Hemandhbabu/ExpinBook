import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'expin_book_app.dart';
import 'presentation/app_lock_package/app_lock_utils.dart';
import 'provider/preferences_provider.dart';
import 'provider/use_cases_provider.dart';
import 'utils/notification_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabase();
  final prefs = await SharedPreferencesWrapper.instance;
  AppLockUtils.initialize(prefs);
  await initializeNotification();
  runApp(const ProviderScope(child: ExpinBookApp()));
}
