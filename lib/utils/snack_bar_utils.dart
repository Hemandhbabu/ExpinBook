import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../presentation/main_page.dart';
import 'snack_bar_data.dart';

final snackBarProvider = StateProvider<SnackBarData?>((ref) => null);

showSnackBar(SnackBarData data) {
  final state = ScaffoldMessenger.maybeOf(scaffoldKey.currentContext!);
  if (state == null || !state.mounted) return null;
  state.removeCurrentSnackBar();
  state.showSnackBar(
    SnackBar(
      content: Text(data.message),
      duration: data.duration,
      padding: data.padding,
      margin: data.margin,
      behavior: data.behavior,
      action: data.action == null
          ? null
          : SnackBarAction(label: data.actionLabel, onPressed: data.action!),
    ),
  );
}
