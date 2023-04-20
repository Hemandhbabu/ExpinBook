import '../../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/base_extensions.dart';
import '../../../utils/theme.dart';
import '../../core/currency_text.dart';
import '../add_budget_provider.dart';

class AmountCard extends ConsumerWidget {
  const AmountCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final amount = ref.watch(AddBudgetProvider.amountProvider);
    return AddEditInfoCard(
      title: 'Amount',
      onTap: () => showAmountGetter(context, amount).then(
        (value) => value?.let(
          (value) => ref
              .read(AddBudgetProvider.amountProvider.notifier)
              .update((state) => value),
        ),
      ),
      child: CustomTile(
        leadingIcon: Icons.money_rounded,
        padding: const EdgeInsets.symmetric(vertical: 5),
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        title: amount > 0 ? ref.watch(currencyFormat(amount)) : 'Enter amount',
        titleSize: amount > 0 ? 22 : 18,
        titleColor: amount > 0
            ? null
            : Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.3),
      ),
    );
  }
}

final _amountProvider = StateProvider.autoDispose((ref) => '');

Future<double?> showAmountGetter(BuildContext context, double initialAmount) =>
    showModalBottomSheet<double>(
      context: context,
      isScrollControlled: true,
      builder: (context) => ProviderScope(
        overrides: [
          if (initialAmount > 0)
            _amountProvider.overrideWith((ref) => '$initialAmount'),
        ],
        child: const _AmountGetter(),
      ),
    );

class _AmountGetter extends ConsumerWidget {
  const _AmountGetter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.viewInsets.bottom;
    final height = mediaQuery.size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Text(
              'Enter amount',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: height * 0.075),
          CustomTextField(
            autoFocus: true,
            provider: _amountProvider,
            textAlign: TextAlign.center,
            fillColor: Colors.transparent,
            hintText: 'Amount',
            maxLines: 1,
            minLines: 1,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              LengthLimitingTextInputFormatter(8),
            ],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            contentPadding: const EdgeInsets.all(24),
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            labelStyle: const TextStyle(fontSize: 40),
          ),
          SizedBox(height: height * 0.075),
          ElevatedButton(
            onPressed: () => Navigator.pop(
              context,
              double.tryParse(ref.read(_amountProvider)) ?? 0,
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
              shape: shape,
            ),
            child: const Text('Add amount'),
          ),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
