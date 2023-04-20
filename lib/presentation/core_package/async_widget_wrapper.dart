import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'center_text.dart';

class AsyncWidgetWrapper<T> extends StatelessWidget {
  final AsyncValue<T?> asyncValue;
  final Widget Function(BuildContext context)? nullBuilder;
  final Widget Function(BuildContext context, String error)? errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context, T data) builder;
  final bool useNullBuilder;
  const AsyncWidgetWrapper({
    super.key,
    required this.asyncValue,
    this.nullBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    required this.builder,
    this.useNullBuilder = true,
  });

  @override
  Widget build(BuildContext context) {
    const aspectRatio = 1.75;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: asyncValue.when(
        data: (data) => data == null
            ? !useNullBuilder
                ? const SizedBox.shrink()
                : nullBuilder?.call(context) ??
                    const AspectRatio(
                      key: ValueKey('null'),
                      aspectRatio: aspectRatio,
                      child: CenterText('No value'),
                    )
            : builder(context, data),
        error: (error, stackTrace) {
          debugPrint(error.toString());
          debugPrint(stackTrace.toString());
          return errorBuilder?.call(context, '$error') ??
              AspectRatio(
                key: ValueKey(error),
                aspectRatio: aspectRatio,
                child: CenterText('$error'),
              );
        },
        loading: () => loadingBuilder?.call(context) ?? const SizedBox.shrink(),
      ),
    );
  }
}
