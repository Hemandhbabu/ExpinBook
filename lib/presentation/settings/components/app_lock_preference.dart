import '../../app_lock_package/app_lock.dart';
import '../../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/show_action_utils.dart';

class AppLockPreference extends ConsumerWidget {
  const AppLockPreference({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasAppLock = ref.watch(hasLockPreferencesProvider);
    return CustomTile(
      title: 'Lock app',
      padding: const EdgeInsets.symmetric(vertical: 5),
      trailing: IgnorePointer(
        child: Switch(
          value: hasAppLock,
          onChanged: (value) {},
        ),
      ),
      onTap: () => hasAppLock
          ? showCustomAction(
              context,
              TileActionData(
                actions: [
                  const TileAction(
                    text: 'Change PIN',
                    value: 0,
                    icon: Icons.loop_rounded,
                  ),
                  const TileAction(
                    text: 'Turn off app lock',
                    value: 1,
                    icon: Icons.lock_open_rounded,
                  ),
                ],
                valueChanged: (value) async {
                  if (value == 0) {
                    final result = await Navigator.pushNamed(
                      context,
                      AppLockPage.route,
                      arguments: const AppLockArg(
                        data: AppLockData.change(),
                        useForceClose: false,
                      ),
                    );
                    if (result is String) {
                      ref
                          .read(lockPasswordPreferencesProvider.notifier)
                          .setString(result);
                    }
                  } else if (value == 1) {
                    final result = await Navigator.pushNamed(
                      context,
                      AppLockPage.route,
                      arguments: const AppLockArg(
                        data: AppLockData.off(),
                        useForceClose: false,
                      ),
                    );
                    if (result is bool && result) {
                      ref
                          .read(hasLockPreferencesProvider.notifier)
                          .setBool(false);
                      ref
                          .read(lockPasswordPreferencesProvider.notifier)
                          .removeKey();
                    }
                  }
                },
              ),
            )
          : Navigator.pushNamed(
              context,
              AppLockPage.route,
              arguments: const AppLockArg(
                data: AppLockData.set(),
                useForceClose: false,
              ),
            ).then((value) {
              if (value is String) {
                ref.read(hasLockPreferencesProvider.notifier).setBool(true);
                ref
                    .read(lockPasswordPreferencesProvider.notifier)
                    .setString(value);
              }
            }),
    );
  }
}
