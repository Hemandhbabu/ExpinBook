import '../../app_lock_package/app_lock.dart';
import '../../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SecurityQuestionPreference extends ConsumerWidget {
  const SecurityQuestionPreference({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      crossFadeState: ref.watch(hasLockPreferencesProvider)
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      firstChild: const SizedBox.shrink(),
      secondChild: CustomTile(
        title: 'Security question',
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        padding: const EdgeInsets.symmetric(vertical: 5),
        onTap: () async {
          final navigator = Navigator.of(context);
          final isVerified = await navigator.pushNamed(
            AppLockPage.route,
            arguments: const AppLockArg(
              data: AppLockData.verify(),
              useForceClose: false,
            ),
          );
          if (isVerified is bool && isVerified) {
            navigator.pushNamed(SecurityQuestionPage.route, arguments: false);
          }
        },
      ),
    );
  }
}
