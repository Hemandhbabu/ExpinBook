import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/expin.dart';
import '../../core_package/core_widget.dart';
import '../../utils/show_action_utils.dart';
import '../add_transaction_provider.dart';

class TypeCard extends ConsumerWidget {
  const TypeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = ref.watch(AddTransactionProvider.typeProvider);
    final editable = ref.watch(AddTransactionProvider.editableProvider);
    return IgnorePointer(
      ignoring: !editable,
      child: AddEditInfoCard(
        title: 'Transaction type',
        onTap: editable
            ? () => showCustomAction(
                  context,
                  TileActionData(
                    selectedAction: type,
                    actions: [
                      ...TransactionType.values.map(
                        (e) => TileAction(
                          text: e.name,
                          value: e,
                          icon: e.icon,
                          iconColor: e.color,
                        ),
                      ),
                    ],
                    valueChanged: (value) => ref
                        .read(AddTransactionProvider.typeProvider.notifier)
                        .update((state) => value),
                  ),
                )
            : null,
        child: CustomTile(
          titleSize: 18,
          leadingIcon: type.icon,
          leadingColor: type.color,
          padding: const EdgeInsets.symmetric(vertical: 5),
          color: Colors.transparent,
          margin: EdgeInsets.zero,
          title: type.name,
        ),
      ),
    );
  }
}
