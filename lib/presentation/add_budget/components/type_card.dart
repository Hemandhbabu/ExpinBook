import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/theme.dart';
import '../../core_package/core_widget.dart';
import '../add_budget_provider.dart';

class TypeCard extends ConsumerWidget {
  const TypeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTotal = ref.watch(AddBudgetProvider.isTotalBudgetProvider);
    final selected = Theme.of(context).colorScheme.primary;
    return AddEditInfoCard(
      title: 'Budget type',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: Row(
          children: [
            Expanded(
              child: _Type(
                margin: const EdgeInsets.all(8),
                title: 'Total',
                color: isTotal ? selected : null,
                onTap: () => isTotal
                    ? null
                    : ref
                        .watch(AddBudgetProvider.isTotalBudgetProvider.notifier)
                        .update((state) => true),
              ),
            ),
            Expanded(
              child: _Type(
                margin: const EdgeInsets.all(8),
                title: 'Category',
                color: !isTotal ? selected : null,
                onTap: () => isTotal
                    ? ref
                        .watch(AddBudgetProvider.isTotalBudgetProvider.notifier)
                        .update((state) => false)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Type extends StatelessWidget {
  final EdgeInsets margin;
  final String title;
  final Color? color;
  final VoidCallback onTap;
  const _Type({
    required this.margin,
    required this.title,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      color: color?.withOpacity(0.15),
      elevation: 0,
      child: InkWell(
        customBorder: shape,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
