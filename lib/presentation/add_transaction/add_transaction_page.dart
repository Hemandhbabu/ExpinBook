import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/expin_data.dart';
import '../../utils/base_extensions.dart';
import '../core_package/core_widget.dart';
import 'add_transaction_provider.dart';
import 'components/amount_card.dart';
import 'components/category_card.dart';
import 'components/date_card.dart';
import 'components/description_card.dart';
import 'components/payment_card.dart';
import 'components/pick_image_card.dart';
import 'components/to_payment_card.dart';
import 'components/type_card.dart';

class AddTransactionPage extends StatelessWidget {
  static const route = 'add-transaction-page';
  final bool editable;
  final ExpinData? expinData;
  const AddTransactionPage({
    super.key,
    required this.editable,
    required this.expinData,
  });

  List<Override> buildOverrides() {
    final expin = expinData?.expin;
    if (expin == null) return [];
    return [
      AddTransactionProvider.dateProvider.overrideWith((ref) => expin.dateTime),
      AddTransactionProvider.amountProvider.overrideWith((ref) => expin.amount),
      AddTransactionProvider.descriptionProvider
          .overrideWith((ref) => expin.description ?? ''),
      AddTransactionProvider.typeProvider.overrideWith((ref) => expin.type),
      AddTransactionProvider.imagePathProvider
          .overrideWith((ref) => expin.imagePath),
      AddTransactionProvider.categoryProvider
          .overrideWith((ref) => expin.categoryId),
      AddTransactionProvider.paymentProvider
          .overrideWith((ref) => expin.paymentId),
      AddTransactionProvider.toPaymentProvider
          .overrideWith((ref) => expin.toPaymentId),
      AddTransactionProvider.validatorProvider
          .overrideWith(AddTransactionProvider.validator),
      AddTransactionProvider.editableProvider.overrideWith((ref) => editable)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: buildOverrides(),
      child: Scaffold(
        appBar: CustomAppBar.elevated(
          provider: AddTransactionProvider.elevatedProvider,
          titleWidget: Consumer(
            builder: (context, ref, child) {
              final text = ref
                  .watch(AddTransactionProvider.editableProvider)
                  .let((editable) {
                if (editable) {
                  return '${expinData == null ? 'Add' : 'Edit'} transaction';
                } else {
                  return 'Transaction';
                }
              });
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(text, key: ValueKey(text)),
              );
            },
          ),
          actions: [
            if (expinData != null)
              Consumer(
                builder: (context, ref, child) {
                  final editable =
                      ref.watch(AddTransactionProvider.editableProvider);
                  if (editable) {
                    return IconButton(
                      onPressed: () => AddTransactionProvider.delete(
                        context,
                        ref.read,
                        expinData!.expin,
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
            Consumer(
              builder: (context, ref, child) {
                final editable =
                    ref.watch(AddTransactionProvider.editableProvider);
                final valid = ref.watch(
                  AddTransactionProvider.validatorProvider(expinData?.expin),
                );
                return IconButton(
                  onPressed: editable
                      ? valid
                          ? () => AddTransactionProvider.save(
                                context,
                                ref.read,
                                expinData?.expin.id ?? -1,
                              )
                          : null
                      : () => ref
                          .read(
                              AddTransactionProvider.editableProvider.notifier)
                          .update((state) => true),
                  icon:
                      Icon(editable ? Icons.save_rounded : Icons.edit_rounded),
                );
              },
            ),
          ],
        ),
        body: ScrollNotificationWrapper(
          provider: AddTransactionProvider.elevatedProvider,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            children: const [
              DateCard(),
              SizedBox(height: 12),
              AmountCard(),
              SizedBox(height: 12),
              TypeCard(),
              SizedBox(height: 12),
              CategoryCard(),
              PaymentCard(),
              SizedBox(height: 12),
              ToPaymentCard(),
              DescriptionCard(),
              SizedBox(height: 12),
              PickImageCard(),
            ],
          ),
        ),
      ),
    );
  }
}
