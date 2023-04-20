import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app_lock_package/app_lock.dart';
import '../../core_package/core_widget.dart';

class PromptFingerprintPreference extends ConsumerWidget {
  const PromptFingerprintPreference({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      crossFadeState: ref.watch(hasFingerprintLockPreferencesProvider)
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: const SizedBox.shrink(),
      secondChild: () {
        final promptFingerprint =
            ref.watch(promptFingerprintPreferencesProvider);
        return CustomTile(
          title: 'Prompt fingerprint',
          trailing: IgnorePointer(
            child: Switch(
              value: promptFingerprint,
              onChanged: (value) {},
            ),
          ),
          margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          padding: const EdgeInsets.symmetric(vertical: 5),
          onTap: () => ref
              .read(promptFingerprintPreferencesProvider.notifier)
              .setBool(!promptFingerprint),
        );
      }(),
    );
  }
}
