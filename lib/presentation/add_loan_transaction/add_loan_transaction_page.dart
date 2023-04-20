import '../../domain/models/loan_transaction.dart';
import '../../utils/base_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core_package/custom_app_bar.dart';
import '../core_package/scroll_notification_wrapper.dart';
import 'add_loan_transaction_provider.dart';
import 'components/amount_card.dart';
import 'components/date_card.dart';
import 'components/description_card.dart';
import 'components/pick_image_card.dart';
import 'components/type_card.dart';

class AddLoanTransactionPage extends StatelessWidget {
  static const route = 'add-loan-transaction-page';
  final bool editable;
  final int loanId;
  final LoanTransaction? transaction;
  const AddLoanTransactionPage({
    super.key,
    required this.editable,
    required this.transaction,
    required this.loanId,
  });

  List<Override> buildOverrides() {
    final transaction = this.transaction;
    if (transaction == null) {
      return [
        AddLoanTransactionProvider.loanProvider.overrideWith((ref) => loanId),
        AddLoanTransactionProvider.validatorProvider
            .overrideWith(AddLoanTransactionProvider.validator),
      ];
    }
    return [
      AddLoanTransactionProvider.dateProvider
          .overrideWith((ref) => transaction.dateTime),
      AddLoanTransactionProvider.amountProvider
          .overrideWith((ref) => transaction.amount),
      AddLoanTransactionProvider.descriptionProvider
          .overrideWith((ref) => transaction.description ?? ''),
      AddLoanTransactionProvider.imagePathProvider
          .overrideWith((ref) => transaction.imagePath),
      AddLoanTransactionProvider.loanProvider
          .overrideWith((ref) => transaction.loanId),
      AddLoanTransactionProvider.isPayProvider
          .overrideWith((ref) => transaction.isPay),
      AddLoanTransactionProvider.validatorProvider
          .overrideWith(AddLoanTransactionProvider.validator),
      AddLoanTransactionProvider.editableProvider
          .overrideWith((ref) => editable)
    ];
  }

  @override
  Widget build(BuildContext context) {
    final transaction = this.transaction;
    return ProviderScope(
      overrides: buildOverrides(),
      child: Scaffold(
        appBar: CustomAppBar.elevated(
          provider: AddLoanTransactionProvider.elevatedProvider,
          titleWidget: Consumer(
            builder: (context, ref, child) {
              final text = ref
                  .watch(AddLoanTransactionProvider.editableProvider)
                  .let((editable) {
                if (editable) {
                  return '${transaction == null ? 'Add' : 'Edit'} transaction';
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
            if (transaction != null)
              Consumer(
                builder: (context, ref, child) {
                  final editable =
                      ref.watch(AddLoanTransactionProvider.editableProvider);
                  if (editable) {
                    return IconButton(
                      onPressed: () => AddLoanTransactionProvider.delete(
                        context,
                        ref.read,
                        transaction,
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
                    ref.watch(AddLoanTransactionProvider.editableProvider);
                final valid = ref.watch(
                  AddLoanTransactionProvider.validatorProvider(transaction),
                );
                return IconButton(
                  onPressed: editable
                      ? valid
                          ? () => AddLoanTransactionProvider.save(
                                context,
                                ref.read,
                                transaction?.id ?? -1,
                              )
                          : null
                      : () => ref
                          .read(AddLoanTransactionProvider
                              .editableProvider.notifier)
                          .update((state) => true),
                  icon:
                      Icon(editable ? Icons.save_rounded : Icons.edit_rounded),
                );
              },
            ),
          ],
        ),
        body: ScrollNotificationWrapper(
          provider: AddLoanTransactionProvider.elevatedProvider,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            children: const [
              DateCard(),
              SizedBox(height: 12),
              AmountCard(),
              SizedBox(height: 12),
              TypeCard(),
              SizedBox(height: 12),
              DescriptionCard(),
              PickImageCard(),
            ],
          ),
        ),
      ),
    );
  }
}
