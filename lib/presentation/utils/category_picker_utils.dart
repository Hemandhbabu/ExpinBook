import '../../provider/use_cases_provider.dart';
import '../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/category.dart';
import '../core/filter_item.dart';

Future<Category?> showCategoryPicker(BuildContext context, Category selected) =>
    showDialog(
      context: context,
      builder: (context) => ProviderScope(
        overrides: [
          _categoryProvider.overrideWith((ref) => selected),
        ],
        child: const _CategoryPicker(),
      ),
    );

final _elevatedProvider = StateProvider.autoDispose((ref) => false);
final _categoryProvider =
    StateProvider.autoDispose<Category>((ref) => throw UnimplementedError());
final _categoriesProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(
    categoryUseCasesProvider.select(
      (value) => value.getAllCategory.watchAll(),
    ),
  ),
);

class _CategoryPicker extends ConsumerWidget {
  const _CategoryPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(_categoryProvider);
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: _elevatedProvider,
        title: 'Select category',
        leading: const CustomCloseButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_rounded),
            tooltip: 'Select',
            onPressed: () =>
                Navigator.pop(context, ref.read(_categoryProvider)),
          ),
        ],
      ),
      body: ScrollNotificationWrapper(
        provider: _elevatedProvider,
        child: AsyncWidgetWrapper(
          asyncValue: ref.watch(_categoriesProvider),
          loadingBuilder: (context) => const LoadingChips(),
          builder: (context, categories) => ListView(
            padding: const EdgeInsets.all(8),
            children: [
              Wrap(
                children: categories
                    .map(
                      (category) => FilterItem(
                        text: category.name,
                        margin: const EdgeInsets.all(4),
                        showDropdown: false,
                        selected: selected.id == category.id,
                        selectedColor:
                            category.isIncome ? Colors.green : Colors.red,
                        onTap: () => ref
                            .read(_categoryProvider.notifier)
                            .update((state) => category),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
