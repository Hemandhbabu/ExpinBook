import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ElevationBuilder extends ConsumerWidget {
  final AutoDisposeStateProvider<bool> provider;
  final Widget child;
  const ElevationBuilder({
    Key? key,
    required this.provider,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      type: MaterialType.card,
      elevation: ref.watch(provider) ? 0.75 : 0,
      child: child,
    );
  }
}
