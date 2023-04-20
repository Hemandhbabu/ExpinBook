import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/preferences_provider.dart';
import '../../core_package/core_widget.dart';

class ShowSavingsPreference extends ConsumerWidget {
  const ShowSavingsPreference({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showSavings = ref.watch(showSavingsPreferencesProvider);
    return CustomTile(
      title: 'Show savings',
      trailing: IgnorePointer(
        child: Switch(
          value: showSavings,
          onChanged: (value) {},
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5),
      onTap: () => ref
          .read(showSavingsPreferencesProvider.notifier)
          .setBool(!showSavings),
    );
  }
}
