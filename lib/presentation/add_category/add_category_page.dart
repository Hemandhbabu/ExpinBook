import '../core_package/core_widget.dart';

import '../../domain/models/category.dart';
import 'add_category_provider.dart';
import 'components/color_card.dart';
import '../../utils/base_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/description_card.dart';
import 'components/icon_card.dart';
import 'components/name_card.dart';
import 'components/type_card.dart';

class AddCategoryPage extends StatelessWidget {
  static const route = 'add-category-page';
  final bool editable;
  final Category? category;
  const AddCategoryPage({
    super.key,
    required this.editable,
    required this.category,
  });

  List<Override> buildOverrides() {
    final category = this.category;
    if (category == null) return [];
    return [
      AddCategoryProvider.nameProvider.overrideWith((ref) => category.name),
      AddCategoryProvider.iconProvider.overrideWith((ref) => category.icon),
      AddCategoryProvider.symbolProvider.overrideWith((ref) => category.symbol),
      AddCategoryProvider.isIncomeProvider
          .overrideWith((ref) => category.isIncome),
      AddCategoryProvider.colorProvider.overrideWith((ref) => category.color),
      AddCategoryProvider.descriptionProvider
          .overrideWith((ref) => category.description ?? ''),
      AddCategoryProvider.validatorProvider
          .overrideWith(AddCategoryProvider.validator),
      AddCategoryProvider.editableProvider.overrideWith((ref) => editable)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: buildOverrides(),
      child: Scaffold(
        appBar: CustomAppBar.elevated(
          provider: AddCategoryProvider.elevatedProvider,
          titleWidget: Consumer(
            builder: (context, ref, child) {
              final text = ref
                  .watch(AddCategoryProvider.editableProvider)
                  .let((editable) {
                if (editable) {
                  return '${category == null ? 'Add' : 'Edit'} category';
                } else {
                  return 'Category';
                }
              });
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(text, key: ValueKey(text)),
              );
            },
          ),
          actions: [
            if (category != null)
              Consumer(
                builder: (context, ref, child) {
                  final editable =
                      ref.watch(AddCategoryProvider.editableProvider);
                  if (editable) {
                    return IconButton(
                      onPressed: () => AddCategoryProvider.delete(
                        context,
                        ref.read,
                        category!,
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
            if (category?.id != 1 && category?.id != 6)
              Consumer(
                builder: (context, ref, child) {
                  final editable =
                      ref.watch(AddCategoryProvider.editableProvider);
                  final valid = ref.watch(
                    AddCategoryProvider.validatorProvider(category),
                  );
                  return IconButton(
                    onPressed: editable
                        ? valid
                            ? () => AddCategoryProvider.save(
                                  context,
                                  ref.read,
                                  category?.id ?? -1,
                                )
                            : null
                        : () => ref
                            .read(AddCategoryProvider.editableProvider.notifier)
                            .update((state) => true),
                    icon: Icon(
                      editable ? Icons.save_rounded : Icons.edit_rounded,
                    ),
                  );
                },
              ),
          ],
        ),
        body: ScrollNotificationWrapper(
          provider: AddCategoryProvider.elevatedProvider,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            children: [
              const NameCard(),
              const SizedBox(height: 12),
              TypeCard(changeable: category == null),
              const SizedBox(height: 12),
              Row(
                children: const [
                  Expanded(child: IconCard()),
                  Expanded(child: ColorCard()),
                ],
              ),
              const SizedBox(height: 12),
              const DescriptionCard(),
            ],
          ),
        ),
      ),
    );
  }
}
