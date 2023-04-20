import '../../app_lock_package/app_lock.dart';
import '../../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _authStatusProvider =
    FutureProvider.autoDispose((ref) => AppLockUtils.canAuth());

class UseFingerprintPreference extends ConsumerWidget {
  const UseFingerprintPreference({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      hasLockPreferencesProvider,
      (previous, next) {
        if (!next) {
          ref
              .read(hasFingerprintLockPreferencesProvider.notifier)
              .setBool(false);
        }
      },
    );
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      crossFadeState: ref.watch(hasLockPreferencesProvider)
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: const SizedBox.shrink(),
      secondChild: () {
        final useFingerprint = ref.watch(hasFingerprintLockPreferencesProvider);
        final authStatus = ref.watch(_authStatusProvider);
        final errorMessage = authStatus.when(
          data: (data) => data?.canAuth == true
              ? null
              : data?.authData ?? 'Error while fetching about biometrics',
          error: (error, stackTrace) => error.toString(),
          loading: () => 'Loading...',
        );
        return CustomTile(
          title: 'Use fingerprint',
          subtitle: errorMessage,
          trailing: errorMessage != null
              ? null
              : IgnorePointer(
                  child: Switch(
                    value: useFingerprint,
                    onChanged: (value) {},
                  ),
                ),
          margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          padding: const EdgeInsets.symmetric(vertical: 5),
          onTap: () async {
            if (await authenticate(context)) {
              ref
                  .read(hasFingerprintLockPreferencesProvider.notifier)
                  .setBool(!useFingerprint);
            }
          },
        );
      }(),
    );
  }
}
