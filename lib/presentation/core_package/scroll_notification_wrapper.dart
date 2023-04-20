import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScrollNotificationWrapper extends ConsumerWidget {
  final AutoDisposeStateProvider<bool> provider;
  final Widget Function(BuildContext context, WidgetRef ref, Widget? child)?
      builder;
  final Widget? child;
  const ScrollNotificationWrapper({
    Key? key,
    required this.provider,
    this.builder,
    this.child,
  })  : assert(builder != null || child != null),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (notification) {
        final showDivider = ref.read(provider);

        if (notification.metrics.pixels > 2 && !showDivider) {
          ref.read(provider.notifier).state = true;
        } else if (notification.metrics.pixels <= 2 && showDivider) {
          ref.read(provider.notifier).state = false;
        }
        return true;
      },
      child: builder?.call(context, ref, child) ?? child!,
    );
  }
}
