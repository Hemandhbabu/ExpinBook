import '../../provider/use_cases_provider.dart';

import '../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/category.dart';
import '../core/filter_item.dart';
import 'category_filter.dart';

final _expandedProvider = StateProvider.autoDispose((ref) => false);
final _multiSelectProvider = StateProvider.autoDispose((ref) => false);
final _elevatedProvider = StateProvider.autoDispose((ref) => false);
final _selectedProvider =
    StateProvider.autoDispose((ref) => const CategoryFilter.all());

int _idSort(Category o, Category t) => o.id!.compareTo(t.id!);
int _incomeSort(Category o, Category t) => o.isIncome == t.isIncome
    ? 0
    : o.isIncome
        ? -1
        : 1;

Future<CategoryFilter?> showCategoryFilter(
  BuildContext context,
  CategoryFilter selected,
  bool useTransfer,
) =>
    showDialog<CategoryFilter>(
      context: context,
      builder: (context) => ProviderScope(
        overrides: [
          _selectedProvider.overrideWith((ref) => selected),
          _multiSelectProvider.overrideWith(
            (ref) => selected.maybeWhen(
              orElse: () => false,
              categories: (categories) => categories.length > 1,
            ),
          ),
          _expandedProvider.overrideWith(
            (ref) => selected.maybeWhen(
              orElse: () => false,
              categories: (categories) => categories.length > 1,
            ),
          ),
        ],
        child: _CategoryFilter(useTransfer),
      ),
    );

final _categoriesProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(
    categoryUseCasesProvider.select(
      (value) => value.getAllCategory.watchAll(),
    ),
  ),
);

class _CategoryFilter extends ConsumerWidget {
  final bool useTransfer;
  const _CategoryFilter(this.useTransfer);

  CategoryFilter getCategoryFilter({
    required bool add,
    required bool selectMultiple,
    required CategoryFilter filter,
    required Category item,
  }) =>
      selectMultiple
          ? filter.maybeWhen(
              orElse: () => CategoryFilter.category(item),
              category: (category) => add
                  ? category.id == item.id
                      ? filter
                      : CategoryFilter.categories(
                          [category, item]
                            ..sort(_idSort)
                            ..sort(_incomeSort),
                        )
                  : const CategoryFilter.all(),
              categories: (categories) {
                if (add) {
                  return categories.map((e) => e.id).contains(item.id)
                      ? filter
                      : CategoryFilter.categories(
                          [...categories, item]
                            ..sort(_idSort)
                            ..sort(_incomeSort),
                        );
                } else {
                  final local = [...categories];
                  local.removeWhere((element) => element.id == item.id);
                  local.sort(_idSort);
                  local.sort(_incomeSort);
                  return local.isEmpty
                      ? const CategoryFilter.all()
                      : local.length == 1
                          ? CategoryFilter.category(local[0])
                          : CategoryFilter.categories(local);
                }
              },
            )
          : CategoryFilter.category(item);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(_selectedProvider);
    final isExpanded = ref.watch(_expandedProvider);
    final isMultiSelect = ref.watch(_multiSelectProvider);
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: _elevatedProvider,
        title: 'Category filter',
        leading: const CustomCloseButton(),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context, selected),
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
              if (!isMultiSelect) ...[
                const TitleCard(title: 'Select all categories'),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FilterItem(
                    text: 'Select all',
                    showDropdown: false,
                    selected: selected.maybeWhen(
                        orElse: () => false, all: () => true),
                    onTap: () => ref.read(_selectedProvider.notifier).state =
                        const CategoryFilter.all(),
                  ),
                ),
                const SizedBox(height: 4),
                const TitleCard(title: 'Select type'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Wrap(
                    children: [
                      FilterItem(
                        text: 'Incomes',
                        showDropdown: false,
                        selectedColor: Colors.green,
                        margin: const EdgeInsets.all(4),
                        selected: selected.maybeWhen(
                            orElse: () => false, income: () => true),
                        onTap: () => ref
                            .read(_selectedProvider.notifier)
                            .state = const CategoryFilter.income(),
                      ),
                      FilterItem(
                        text: 'Expenses',
                        showDropdown: false,
                        selectedColor: Colors.red,
                        margin: const EdgeInsets.all(4),
                        selected: selected.maybeWhen(
                            orElse: () => false, expense: () => true),
                        onTap: () => ref
                            .read(_selectedProvider.notifier)
                            .state = const CategoryFilter.expense(),
                      ),
                      if (useTransfer)
                        FilterItem(
                          text: 'Transfers',
                          showDropdown: false,
                          selectedColor: Colors.blue,
                          margin: const EdgeInsets.all(4),
                          selected: selected.maybeWhen(
                              orElse: () => false, transfer: () => true),
                          onTap: () => ref
                              .read(_selectedProvider.notifier)
                              .state = const CategoryFilter.transfer(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
              ],
              TitleCard(
                title: 'Select a category',
                trailing: TextButton(
                  onPressed: () {
                    final result = !isMultiSelect;
                    ref.read(_multiSelectProvider.notifier).state = result;
                    if (isMultiSelect) {
                      ref.read(_selectedProvider.notifier).state =
                          const CategoryFilter.all();
                    } else if (!isExpanded) {
                      ref.read(_expandedProvider.notifier).state = true;
                    }
                  },
                  child: Text('Select ${isMultiSelect ? 'one' : 'multiple'}'),
                ),
              ),
              () {
                final selectedCategories = selected.maybeWhen(
                  orElse: () => null,
                  category: (category) => [category],
                  categories: (categories) => categories,
                );
                final selectedIds =
                    selectedCategories?.map((e) => e.id).toList() ?? [];
                final notExpandedItem = selectedCategories?.isNotEmpty == true
                    ? selectedCategories![0]
                    : categories[0];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Wrap(
                    children: [
                      if (!isExpanded)
                        FilterItem(
                          text: notExpandedItem.name,
                          showDropdown: false,
                          selected: selectedIds.contains(notExpandedItem.id),
                          selectedColor: notExpandedItem.isIncome
                              ? Colors.green
                              : Colors.red,
                          margin: const EdgeInsets.all(4),
                          onTap: () => ref
                              .read(_selectedProvider.notifier)
                              .state = getCategoryFilter(
                            selectMultiple: isMultiSelect,
                            add: !selectedIds.contains(notExpandedItem.id),
                            filter: selected,
                            item: notExpandedItem,
                          ),
                        ),
                      if (!isExpanded)
                        FilterItem(
                          key: const ValueKey('...'),
                          text: '...',
                          showDropdown: false,
                          margin: const EdgeInsets.all(4),
                          onTap: () =>
                              ref.read(_expandedProvider.notifier).state = true,
                        ),
                      if (isExpanded)
                        ...categories.map(
                          (e) => FilterItem(
                            text: e.name,
                            showDropdown: false,
                            margin: const EdgeInsets.all(4),
                            selected: selectedIds.contains(e.id),
                            selectedColor:
                                e.isIncome ? Colors.green : Colors.red,
                            onTap: () =>
                                ref.read(_selectedProvider.notifier).state =
                                    getCategoryFilter(
                                        selectMultiple: isMultiSelect,
                                        add: !selectedIds.contains(e.id),
                                        filter: selected,
                                        item: e),
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
