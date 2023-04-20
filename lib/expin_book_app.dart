import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'provider/preferences_provider.dart';
import 'utils/routes.dart';
import 'utils/theme.dart';

class ExpinBookApp extends ConsumerWidget {
  const ExpinBookApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      routes: routes(),
      theme: theme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.values[ref.watch(themePreferencesProvider)],
      initialRoute: initialRoute,
    );
  }
}
