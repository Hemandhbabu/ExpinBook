import '../../../provider/use_cases_provider.dart';

import '../../../domain/models/expin.dart';
import '../../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/category.dart';
import '../../../utils/base_extensions.dart';
import '../../utils/show_action_utils.dart';
import '../add_transaction_provider.dart';

final _categoryProvider = StreamProvider.autoDispose.family(
  (ref, int id) =>
      ref.watch(categoryUseCasesProvider).getCategory.watchWithId(id),
);

class CategoryCard extends ConsumerWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      AddTransactionProvider.typeProvider,
      (_, next) =>
          ref.read(AddTransactionProvider.categoryProvider.notifier).update(
        (state) {
          switch (next) {
            case TransactionType.income:
              return 1;
            case TransactionType.expense:
              return 6;
            case TransactionType.transfer:
              return -1;
          }
        },
      ),
    );
    final isTransfer = ref.watch(
      AddTransactionProvider.toPaymentProvider.select((value) => value != null),
    );
    if (isTransfer) return const SizedBox.shrink();
    final category = ref.watch(
      _categoryProvider(ref.watch(AddTransactionProvider.categoryProvider)),
    );
    final editable = ref.watch(AddTransactionProvider.editableProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: AsyncWidgetWrapper(
        asyncValue: category,
        useNullBuilder: false,
        builder: (context, category) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AddEditInfoCard(
            title: 'Category',
            onTap: editable
                ? () => showSingleCategoryPicker(
                      context,
                      category,
                      ref.read(AddTransactionProvider.typeProvider) ==
                          TransactionType.income,
                    ).then(
                      (value) => value?.let(
                        (value) => ref
                            .read(AddTransactionProvider
                                .categoryProvider.notifier)
                            .update((state) => value.id!),
                      ),
                    )
                : null,
            child: CustomTile(
              key: ValueKey(category.id),
              titleSize: 18,
              leadingIcon: category.icon,
              leadingColor: category.color,
              leadingSymbol: category.symbol,
              padding: const EdgeInsets.symmetric(vertical: 5),
              color: Colors.transparent,
              margin: EdgeInsets.zero,
              title: category.name,
            ),
          ),
        ),
      ),
    );
  }
}

Future<Category?> showSingleCategoryPicker(
    BuildContext context, Category? category, bool isIncome) {
  final size = MediaQuery.of(context).size;
  return showModalBottomSheet<Category>(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints.loose(Size(size.width, size.height * 0.75)),
    builder: (context) => _SingleCategoryPicker(category, isIncome),
  );
}

final _categoriesProvider = StreamProvider.autoDispose.family(
  (ref, bool isIncome) => ref
      .watch(categoryUseCasesProvider.select((value) => value.getAllCategory))
      .watchAll()
      .map((value) => value.where((e) => e.isIncome == isIncome).toList()),
);

class _SingleCategoryPicker extends ConsumerWidget {
  final Category? category;
  final bool isIncome;
  const _SingleCategoryPicker(this.category, this.isIncome);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = category;
    return AsyncWidgetWrapper(
      asyncValue: ref.watch(_categoriesProvider(isIncome)),
      loadingBuilder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: const [LoadingTile()],
      ),
      builder: (context, data) => Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 8),
        child: SingleChildScrollView(
          child: Wrap(
            children: List.generate(
              data.length,
              (index) {
                final category = data[index];
                final isSelected = selected?.id == category.id;
                return ActionTile(
                  selected: isSelected,
                  foldable: false,
                  action: TileAction(
                    text: category.name,
                    value: category,
                    icon: category.icon,
                    iconColor: category.color,
                    symbol: category.symbol,
                  ),
                  callback: (val) =>
                      Navigator.pop(context, isSelected ? null : val),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
