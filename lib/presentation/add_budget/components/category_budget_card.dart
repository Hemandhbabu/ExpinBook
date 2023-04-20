import 'dart:convert';

import '../../../provider/use_cases_provider.dart';

import '../../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/category.dart';
import '../../../utils/base_extensions.dart';
import '../../core/filter_item.dart';
import '../add_budget_provider.dart';

final _categoriesProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(
    categoryUseCasesProvider.select(
      (value) => value.getAllCategory.watchAll().map(
            (value) => value.where((element) => !element.isIncome).toList(),
          ),
    ),
  ),
);
final _selectedCategoriesProvider = Provider.autoDispose.family(
  (ref, String json) {
    final categoriesBudget = (jsonDecode(json) as List).cast<int>();
    return ref.watch(
      _categoriesProvider.select(
        (value) => value.whenData(
          (value) =>
              value.where((e) => categoriesBudget.contains(e.id)).toList(),
        ),
      ),
    );
  },
);

class CategoryBudgetCard extends ConsumerWidget {
  const CategoryBudgetCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTotal = ref.watch(AddBudgetProvider.isTotalBudgetProvider);
    ref.listen(
      AddBudgetProvider.isTotalBudgetProvider,
      (previous, isTotal) {
        if (isTotal) {
          ref.read(AddBudgetProvider.budgetCategoriesProvider.notifier).clear();
        }
      },
    );
    if (isTotal) return const SizedBox.shrink();
    final selectedIds = ref.watch(AddBudgetProvider.budgetCategoriesProvider);
    return AsyncWidgetWrapper(
      asyncValue: ref.watch(
        _selectedCategoriesProvider(jsonEncode(selectedIds)),
      ),
      builder: (context, categories) => Column(
        children: [
          TitleCard(
            title: 'Categories',
            trailing: IconButton(
              onPressed: () => _showExpenseCategorySelector(
                context,
                selectedIds,
              ).then(
                (value) => value?.let(
                  ref
                      .read(AddBudgetProvider.budgetCategoriesProvider.notifier)
                      .update,
                ),
              ),
              icon: const Icon(Icons.add_rounded),
            ),
          ),
          if (categories.isEmpty)
            const AspectRatio(
              aspectRatio: 1.5,
              child: CenterText('No categories selected'),
            ),
          ...categories.map(
            (category) => _CategorySelectorTile(category: category),
          ),
        ],
      ),
    );
  }
}

class _CategorySelectorTile extends ConsumerWidget {
  final Category category;
  const _CategorySelectorTile({required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTile(
      key: ValueKey(category.id),
      padding: const EdgeInsets.symmetric(vertical: 5),
      leadingIcon: category.icon,
      leadingSymbol: category.symbol,
      leadingColor: category.color,
      title: category.name,
      trailing: IconButton(
        onPressed: () => ref
            .read(AddBudgetProvider.budgetCategoriesProvider.notifier)
            .remove(category.id!),
        icon: const Icon(Icons.close_rounded),
      ),
    );
  }
}

final _elevatedProvider = StateProvider.autoDispose((ref) => false);
final _budgetCategoriesProvider =
    StateNotifierProvider.autoDispose<BudgetCategoriesNotifier, List<int>>(
  (ref) => BudgetCategoriesNotifier(),
);

Future<List<int>?> _showExpenseCategorySelector(
        BuildContext context, List<int> selectedIds) =>
    showDialog<List<int>>(
      context: context,
      builder: (context) => ProviderScope(
        overrides: [
          _budgetCategoriesProvider.overrideWith(
            (ref) => BudgetCategoriesNotifier(selectedIds),
          ),
        ],
        child: const _ExpenseCategorySelector(),
      ),
    );

class _ExpenseCategorySelector extends ConsumerWidget {
  const _ExpenseCategorySelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIds = ref.watch(_budgetCategoriesProvider);
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: _elevatedProvider,
        title: 'Select category',
        leading: const CustomCloseButton(),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context, selectedIds),
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: AsyncWidgetWrapper(
        asyncValue: ref.watch(_categoriesProvider),
        loadingBuilder: (context) => const LoadingChips(),
        builder: (context, categories) => ScrollNotificationWrapper(
          provider: _elevatedProvider,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Wrap(
                  children: [
                    ...categories.map(
                      (e) {
                        final selected = selectedIds.contains(e.id);
                        return FilterItem(
                          text: e.name,
                          showDropdown: false,
                          margin: const EdgeInsets.all(4),
                          selected: selected,
                          selectedColor: e.isIncome ? Colors.green : Colors.red,
                          onTap: () {
                            final notifier =
                                ref.read(_budgetCategoriesProvider.notifier);
                            if (selected) {
                              notifier.remove(e.id!);
                            } else {
                              notifier.add(e.id!);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
