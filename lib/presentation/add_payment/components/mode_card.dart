import '../../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/payment.dart';
import '../../utils/show_action_utils.dart';
import '../add_payment_provider.dart';

class ModeCard extends ConsumerWidget {
  const ModeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(AddPaymentProvider.modeProvider);
    final editable = ref.watch(AddPaymentProvider.editableProvider);
    return AddEditInfoCard(
      title: 'Mode',
      alignment: CrossAxisAlignment.center,
      onTap: editable
          ? () => showCustomAction(
                context,
                TileActionData(
                  selectedAction: mode,
                  actions: [...PaymentMode.values]
                      .where((element) => element != PaymentMode.cash)
                      .map(
                        (e) => TileAction(
                          text: e.name,
                          value: e,
                          icon: e.icon,
                        ),
                      )
                      .toList(),
                  valueChanged: (value) => ref
                      .read(AddPaymentProvider.modeProvider.notifier)
                      .update((state) => value),
                ),
              )
          : null,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Padding(
          key: ValueKey(mode),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Center(
            child: SizedBox.square(
              dimension: 64,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(mode.icon),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
