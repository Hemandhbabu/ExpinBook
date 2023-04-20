import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_lock_package/app_lock/app_lock_arg.dart';
import 'app_lock_package/app_lock/app_lock_page.dart';
import 'app_lock_package/app_lock/utils/app_lock_data.dart';
import 'app_lock_package/preference_provider.dart';
import 'home/home_page.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

final verifiedProvider = StateProvider((ref) => false);

class MainPage extends ConsumerStatefulWidget {
  static const route = 'main_page';
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage>
    with WidgetsBindingObserver {
  AppLifecycleState? _state;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    debugPrint('stateOfMain : init');
    if (ref.read(hasLockPreferencesProvider)) {
      Future.delayed(Duration.zero, navigateAppLock);
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('stateOfMain : dispose');
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _state = state;
    debugPrint("app in ${state.name}");
    switch (state) {
      case AppLifecycleState.paused:
        if (ref.read(hasLockPreferencesProvider) &&
            ref.read(verifiedProvider)) {
          timer = Timer(
            Duration(minutes: ref.read(timeoutPreferencesProvider)),
            () {
              timer = null;
              if (_state == AppLifecycleState.paused ||
                  _state == AppLifecycleState.inactive) {
                ref.read(verifiedProvider.notifier).state = false;
                navigateAppLock();
                debugPrint('unverified');
              } else {
                debugPrint('not unverified');
              }
            },
          );
        }
        break;
      case AppLifecycleState.resumed:
        timer?.cancel();
        timer = null;
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  Future<void> navigateAppLock() => Navigator.pushNamed(
        context,
        AppLockPage.route,
        arguments: AppLockArg(
          data: AppLockData.verify(
            onDone: () =>
                ref.read(verifiedProvider.notifier).update((state) => true),
          ),
          useForceClose: true,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: const HomePage(),
    );
  }
}
