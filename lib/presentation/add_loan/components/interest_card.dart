import '../../../utils/base_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/theme.dart';
import '../../core_package/core_widget.dart';
import '../add_loan_provider.dart';

class InterestCard extends ConsumerWidget {
  const InterestCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interest = ref.watch(AddLoanProvider.interestProvider);
    return AddEditInfoCard(
      title: 'Interest',
      onTap: () => showInterestGetter(context, interest).then(
        (value) => value?.let(
          (value) => ref
              .read(AddLoanProvider.interestProvider.notifier)
              .update((state) => value),
        ),
      ),
      child: CustomTile(
        leadingIcon: Icons.percent_rounded,
        padding: const EdgeInsets.symmetric(vertical: 5),
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        title: interest > 0
            ? interest % 1 == 0
                ? '${interest.toInt()}'
                : interest.toStringAsFixed(2)
            : 'Enter interest',
        titleSize: 18,
        titleColor: interest > 0
            ? null
            : Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.3),
      ),
    );
  }
}

final _interestProvider = StateProvider.autoDispose((ref) => '');

Future<double?> showInterestGetter(
        BuildContext context, double initialInterest) =>
    showModalBottomSheet<double>(
      context: context,
      isScrollControlled: true,
      builder: (context) => ProviderScope(
        overrides: [
          if (initialInterest > 0)
            _interestProvider.overrideWith((ref) => '$initialInterest'),
        ],
        child: const _InterestGetter(),
      ),
    );

class _InterestGetter extends ConsumerWidget {
  const _InterestGetter();

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
              'Enter interest',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: height * 0.075),
          CustomTextField(
            autoFocus: true,
            provider: _interestProvider,
            textAlign: TextAlign.center,
            fillColor: Colors.transparent,
            hintText: 'Interest',
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
              double.tryParse(ref.read(_interestProvider)) ?? 0,
            ),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
              shape: shape,
            ),
            child: const Text('Add interest'),
          ),
          SizedBox(height: bottomPadding),
        ],
      ),
    );
  }
}
