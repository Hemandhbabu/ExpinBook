import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/payment.dart';
import '../../utils/base_extensions.dart';
import '../core_package/core_widget.dart';
import 'add_payment_provider.dart';
import 'components/color_card.dart';
import 'components/description_card.dart';
import 'components/mode_card.dart';
import 'components/name_card.dart';

class AddPaymentPage extends StatelessWidget {
  static const route = 'add-payment-page';
  final bool editable;
  final Payment? payment;
  const AddPaymentPage({
    super.key,
    required this.editable,
    required this.payment,
  });

  List<Override> buildOverrides() {
    final payment = this.payment;
    if (payment == null) return [];
    return [
      AddPaymentProvider.nameProvider.overrideWith((ref) => payment.name),
      AddPaymentProvider.modeProvider.overrideWith((ref) => payment.mode),
      AddPaymentProvider.colorProvider.overrideWith((ref) => payment.color),
      AddPaymentProvider.descriptionProvider
          .overrideWith((ref) => payment.description ?? ''),
      AddPaymentProvider.validatorProvider
          .overrideWith(AddPaymentProvider.validator),
      AddPaymentProvider.editableProvider.overrideWith((ref) => editable)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: buildOverrides(),
      child: Scaffold(
        appBar: CustomAppBar.elevated(
          provider: AddPaymentProvider.elevatedProvider,
          titleWidget: Consumer(
            builder: (context, ref, child) {
              final text = ref
                  .watch(AddPaymentProvider.editableProvider)
                  .let((editable) {
                if (editable) {
                  return '${payment == null ? 'Add' : 'Edit'} payment';
                } else {
                  return 'Payment';
                }
              });
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(text, key: ValueKey(text)),
              );
            },
          ),
          actions: [
            if (payment != null)
              Consumer(
                builder: (context, ref, child) {
                  final editable =
                      ref.watch(AddPaymentProvider.editableProvider);
                  if (editable) {
                    return IconButton(
                      onPressed: () => AddPaymentProvider.delete(
                        context,
                        ref.read,
                        payment!,
                      ).then(
                        (value) =>
                            value == true ? Navigator.pop(context) : null,
                      ),
                      color: Colors.red,
                      icon: const Icon(Icons.delete_rounded),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            if (payment?.id != 1)
              Consumer(
                builder: (context, ref, child) {
                  final editable =
                      ref.watch(AddPaymentProvider.editableProvider);
                  final valid = ref.watch(
                    AddPaymentProvider.validatorProvider(payment),
                  );
                  return IconButton(
                    onPressed: editable
                        ? valid
                            ? () => AddPaymentProvider.save(
                                  context,
                                  ref.read,
                                  payment?.id ?? -1,
                                )
                            : null
                        : () => ref
                            .read(AddPaymentProvider.editableProvider.notifier)
                            .update((state) => true),
                    icon: Icon(
                      editable ? Icons.save_rounded : Icons.edit_rounded,
                    ),
                  );
                },
              ),
          ],
        ),
        body: ScrollNotificationWrapper(
          provider: AddPaymentProvider.elevatedProvider,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            children: [
              const NameCard(),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Expanded(child: ModeCard()),
                  Expanded(child: ColorCard()),
                ],
              ),
              const SizedBox(height: 12),
              const DescriptionCard(),
            ],
          ),
        ),
      ),
    );
  }
}
