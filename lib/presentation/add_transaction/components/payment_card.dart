import '../../../provider/use_cases_provider.dart';

import '../../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/payment.dart';
import '../../../utils/base_extensions.dart';
import '../../utils/show_action_utils.dart';
import '../add_transaction_provider.dart';

final _paymentProvider = StreamProvider.autoDispose.family(
  (ref, int id) =>
      ref.watch(paymentUseCasesProvider).getPayment.watchWithId(id),
);

class PaymentCard extends ConsumerWidget {
  const PaymentCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payment = ref.watch(
      _paymentProvider(ref.watch(AddTransactionProvider.paymentProvider)),
    );
    final editable = ref.watch(AddTransactionProvider.editableProvider);
    return AsyncWidgetWrapper(
      asyncValue: payment,
      useNullBuilder: false,
      builder: (context, payment) => AddEditInfoCard(
        title: 'Payment',
        onTap: editable
            ? () => showSinglePaymentPicker(context, payment).then(
                  (value) => value?.let(
                    (value) => ref
                        .read(AddTransactionProvider.paymentProvider.notifier)
                        .update((state) => value.id!),
                  ),
                )
            : null,
        child: CustomTile(
          titleSize: 18,
          leadingIcon: payment.mode.icon,
          leadingColor: payment.color,
          padding: const EdgeInsets.symmetric(vertical: 5),
          color: Colors.transparent,
          margin: EdgeInsets.zero,
          title: payment.name,
        ),
      ),
    );
  }
}

Future<Payment?> showSinglePaymentPicker(
    BuildContext context, Payment? payment) {
  final size = MediaQuery.of(context).size;
  return showModalBottomSheet<Payment>(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints.loose(Size(size.width, size.height * 0.75)),
    builder: (context) => _SinglePaymentPicker(payment),
  );
}

final _paymentsProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(
    paymentUseCasesProvider.select(
      (value) => value.getAllPayment.watchAll(),
    ),
  ),
);

class _SinglePaymentPicker extends ConsumerWidget {
  final Payment? payment;
  const _SinglePaymentPicker(this.payment);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = payment;
    return AsyncWidgetWrapper(
      asyncValue: ref.watch(_paymentsProvider),
      loadingBuilder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: const [LoadingTile()],
      ),
      builder: (context, data) => Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 8),
        child: SingleChildScrollView(
          child: Wrap(
            children: List.generate(
              data.length,
              (index) {
                final payment = data[index];
                final isSelected = selected?.id == payment.id;
                return ActionTile(
                  selected: isSelected,
                  foldable: false,
                  action: TileAction(
                    text: payment.name,
                    value: payment,
                    iconColor: payment.color,
                    icon: payment.mode.icon,
                  ),
                  callback: (val) =>
                      Navigator.pop(context, isSelected ? null : val),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
