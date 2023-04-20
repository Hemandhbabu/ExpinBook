import '../../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/preferences_provider.dart';
import '../../utils/show_action_utils.dart';

class ThemePreference extends ConsumerWidget {
  const ThemePreference({Key? key}) : super(key: key);

  String getName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  IconData getIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return Icons.brightness_auto_rounded;
      case ThemeMode.light:
        return Icons.light_mode_rounded;
      case ThemeMode.dark:
        return Icons.dark_mode_rounded;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ThemeMode.values[ref.watch(themePreferencesProvider)];
    return CustomTile(
      title: 'Theme',
      padding: const EdgeInsets.symmetric(vertical: 5),
      trailing: Text(
        getName(mode),
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
      ),
      onTap: () => showCustomAction(
        context,
        TileActionData<ThemeMode>(
          selectedAction: mode,
          actions: ThemeMode.values
              .map(
                (e) => TileAction(
                  icon: getIcon(e),
                  text: getName(e),
                  value: e,
                ),
              )
              .toList(),
          valueChanged: (mode) =>
              ref.read(themePreferencesProvider.notifier).setInt(mode.index),
        ),
      ),
    );
  }
}
