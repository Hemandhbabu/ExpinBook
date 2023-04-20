import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/base_extensions.dart';
import '../../core_package/core_widget.dart';
import '../../utils/show_action_utils.dart';
import '../add_loan_transaction_provider.dart';

enum TransactionType {
  pay('Pay', Icons.call_made_rounded, Colors.green),
  lent('Lent', Icons.call_received_rounded, Colors.red);

  final String name;
  final Color color;
  final IconData icon;

  const TransactionType(this.name, this.icon, this.color);
}

class TypeCard extends ConsumerWidget {
  const TypeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final type = ref.watch(AddLoanTransactionProvider.isPayProvider).let(
          (value) => value ? TransactionType.pay : TransactionType.lent,
        );
    final editable = ref.watch(AddLoanTransactionProvider.editableProvider);
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
                      TransactionType.pay.let(
                        (value) => TileAction(
                          text: value.name,
                          value: value,
                          icon: value.icon,
                          iconColor: value.color,
                        ),
                      ),
                      TransactionType.lent.let(
                        (value) => TileAction(
                          text: value.name,
                          value: value,
                          icon: value.icon,
                          iconColor: value.color,
                        ),
                      ),
                    ],
                    valueChanged: (value) => ref
                        .read(AddLoanTransactionProvider.isPayProvider.notifier)
                        .update((state) => value == TransactionType.pay),
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
