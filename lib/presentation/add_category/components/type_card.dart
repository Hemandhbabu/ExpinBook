import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/theme.dart';
import '../../core_package/core_widget.dart';
import '../add_category_provider.dart';

class TypeCard extends ConsumerWidget {
  final bool changeable;
  const TypeCard({super.key, required this.changeable});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isIncome = ref.watch(AddCategoryProvider.isIncomeProvider);
    final editable = ref.watch(AddCategoryProvider.editableProvider);
    return IgnorePointer(
      ignoring: !changeable || !editable,
      child: AddEditInfoCard(
        title: 'Category type',
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: _Type(
                  margin: const EdgeInsets.all(8),
                  title: 'Income',
                  color: isIncome ? Colors.green : null,
                  onTap: () => isIncome
                      ? null
                      : ref
                          .watch(AddCategoryProvider.isIncomeProvider.notifier)
                          .update((state) => true),
                ),
              ),
              Expanded(
                child: _Type(
                  margin: const EdgeInsets.all(8),
                  title: 'Expense',
                  color: !isIncome ? Colors.red : null,
                  onTap: () => isIncome
                      ? ref
                          .watch(AddCategoryProvider.isIncomeProvider.notifier)
                          .update((state) => false)
                      : null,
                ),
              ),
            ],
          ),
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
