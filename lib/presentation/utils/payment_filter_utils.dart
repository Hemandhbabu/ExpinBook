import '../../provider/use_cases_provider.dart';

import '../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/payment.dart';
import '../core/filter_item.dart';
import 'payment_filter.dart';

final _elevatedProvider = StateProvider.autoDispose((ref) => false);
final _multiSelectProvider = StateProvider.autoDispose((ref) => false);
final _selectedProvider =
    StateProvider.autoDispose((ref) => const PaymentFilter.all());
final _paymentsProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(
    paymentUseCasesProvider.select(
      (value) => value.getAllPayment.watchAll(),
    ),
  ),
);

Future<PaymentFilter?> showPaymentFilter(
        BuildContext context, PaymentFilter selected) =>
    showDialog<PaymentFilter>(
      context: context,
      builder: (context) => ProviderScope(
        overrides: [
          _selectedProvider.overrideWith((ref) => selected),
          _multiSelectProvider.overrideWith(
            (ref) => selected.maybeWhen(
              orElse: () => false,
              payments: (payments) => payments.length > 1,
            ),
          ),
        ],
        child: const _PaymentFilter(),
      ),
    );

class _PaymentFilter extends ConsumerWidget {
  const _PaymentFilter();

  int sort(Payment o, Payment t) => o.id!.compareTo(t.id!);

  PaymentFilter getPaymentFilter({
    required bool add,
    required bool selectMultiple,
    required PaymentFilter filter,
    required Payment item,
  }) =>
      selectMultiple
          ? filter.maybeWhen(
              orElse: () => PaymentFilter.payment(item),
              payment: (payment) => add
                  ? payment.id == item.id
                      ? filter
                      : PaymentFilter.payments([payment, item]..sort(sort))
                  : const PaymentFilter.all(),
              payments: (payments) {
                if (add) {
                  return payments.map((e) => e.id).contains(item.id)
                      ? filter
                      : PaymentFilter.payments([...payments, item]..sort(sort));
                } else {
                  final local = [...payments];
                  local.removeWhere((element) => element.id == item.id);
                  local.sort(sort);
                  return local.isEmpty
                      ? const PaymentFilter.all()
                      : local.length == 1
                          ? PaymentFilter.payment(local[0])
                          : PaymentFilter.payments(local);
                }
              },
            )
          : PaymentFilter.payment(item);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(_selectedProvider);
    final isMultiSelect = ref.watch(_multiSelectProvider);
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: _elevatedProvider,
        title: 'Payment filter',
        leading: const CustomCloseButton(),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context, selected),
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: AsyncWidgetWrapper(
        asyncValue: ref.watch(_paymentsProvider),
        loadingBuilder: (context) => const LoadingChips(),
        builder: (context, payments) => ScrollNotificationWrapper(
          provider: _elevatedProvider,
          child: ListView(
            children: [
              if (!isMultiSelect) ...[
                const TitleCard(title: 'Select all'),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FilterItem(
                    text: 'Select all payments',
                    showDropdown: false,
                    selected: selected.maybeWhen(
                        orElse: () => false, all: () => true),
                    onTap: () => ref.read(_selectedProvider.notifier).state =
                        const PaymentFilter.all(),
                  ),
                ),
                const SizedBox(height: 4),
              ],
              TitleCard(
                title: 'Select a payment',
                trailing: TextButton(
                  onPressed: () {
                    final result = !isMultiSelect;
                    ref.read(_multiSelectProvider.notifier).state = result;
                    if (isMultiSelect) {
                      ref.read(_selectedProvider.notifier).state =
                          const PaymentFilter.all();
                    }
                  },
                  child: Text('Select ${isMultiSelect ? 'one' : 'multiple'}'),
                ),
              ),
              () {
                final selectedPayments = selected.maybeWhen(
                  orElse: () => null,
                  payment: (payment) => [payment],
                  payments: (payments) => payments,
                );
                final selectedIds =
                    selectedPayments?.map((e) => e.id).toList() ?? [];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Wrap(
                    children: [
                      ...payments.map(
                        (e) => FilterItem(
                          text: e.name,
                          showDropdown: false,
                          margin: const EdgeInsets.all(4),
                          selected: selectedIds.contains(e.id),
                          onTap: () => ref
                              .read(_selectedProvider.notifier)
                              .state = getPaymentFilter(
                            add: !selectedIds.contains(e.id),
                            selectMultiple: isMultiSelect,
                            filter: selected,
                            item: e,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }(),
            ],
          ),
        ),
      ),
    );
  }
}
