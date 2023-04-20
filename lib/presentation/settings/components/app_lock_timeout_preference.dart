import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app_lock_package/app_lock.dart';
import '../../core_package/core_widget.dart';
import '../../utils/show_action_utils.dart';

class AppLockTimeoutPreference extends ConsumerWidget {
  const AppLockTimeoutPreference({super.key});

  static const _data = [
    TileAction(text: 'Immediately', value: 0),
    TileAction(text: '1 minute', value: 1),
    TileAction(text: '5 minutes', value: 5),
    TileAction(text: '10 minutes', value: 10),
    TileAction(text: '30 minutes', value: 30),
  ];

  String getTimeoutLabel(int minute) {
    if (minute == 0) return 'Immediately';
    if (minute == 1) return '1 minute';
    return '$minute minutes';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeout = ref.watch(timeoutPreferencesProvider);
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      crossFadeState: ref.watch(hasLockPreferencesProvider)
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: const SizedBox.shrink(),
      secondChild: CustomTile(
        title: 'App lock timeout',
        trailing: Text(
          getTimeoutLabel(timeout),
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        padding: const EdgeInsets.symmetric(vertical: 5),
        onTap: () => showCustomAction(
          context,
          TileActionData(
            actions: _data,
            selectedAction: timeout,
            valueChanged: ref.read(timeoutPreferencesProvider.notifier).setInt,
          ),
        ),
      ),
    );
  }
}
