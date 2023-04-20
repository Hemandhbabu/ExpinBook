import '../../../provider/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeIcon extends ConsumerWidget {
  final EdgeInsets margin;
  const ThemeIcon({super.key, this.margin = EdgeInsets.zero});

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
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: IconButton(
        key: ValueKey(mode),
        onPressed: () => ref
            .read(themePreferencesProvider.notifier)
            .setInt((mode.index + 1) % 3),
        icon: Icon(getIcon(mode)),
      ),
    );
  }
}
