import 'dart:convert';

import '../../core_package/core_widget.dart';

import '../../../domain/models/category.dart';
import 'manage_pinned_category_tile.dart';
import '../pinned_categories_provider.dart';
import '../../../utils/snack_bar_data.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/preferences_provider.dart';
import '../../../utils/snack_bar_utils.dart';
import '../../../utils/type_def_utils.dart';

class ManagePinnedCategories extends ConsumerWidget {
  static const route = 'manage-pinned-categories';
  const ManagePinnedCategories({Key? key}) : super(key: key);

  onChanged({
    required BuildContext context,
    required Reader read,
    required bool isSelected,
    required Category category,
  }) {
    if (!isSelected) {
      if (category.isIncome) {
        if (read(PinnedCategoriesProvider.manageIncomePinnedCategoriesProvider)
                .length >=
            5) {
          showSnackBar(
            const SnackBarData(
              message: 'Maximum of 5 income categories can be pinned',
            ),
          );
          return;
        }
      } else {
        if (read(PinnedCategoriesProvider.manageExpensePinnedCategoriesProvider)
                .length >=
            5) {
          showSnackBar(
            const SnackBarData(
              message: 'Maximum of 5 expense categories can be pinned',
            ),
          );
          return;
        }
      }
    }
    if (isSelected) {
      if (category.isIncome) {
        read(PinnedCategoriesProvider
                .manageIncomePinnedCategoriesProvider.notifier)
            .removeCategory(category.id!);
      } else {
        read(PinnedCategoriesProvider
                .manageExpensePinnedCategoriesProvider.notifier)
            .removeCategory(category.id!);
      }
    } else {
      if (category.isIncome) {
        read(PinnedCategoriesProvider
                .manageIncomePinnedCategoriesProvider.notifier)
            .addCategory(category.id!);
      } else {
        read(PinnedCategoriesProvider
                .manageExpensePinnedCategoriesProvider.notifier)
            .addCategory(category.id!);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinnedCategoryIds = [
      ...ref.watch(
        PinnedCategoriesProvider.manageIncomePinnedCategoriesProvider,
      ),
      ...ref.watch(
        PinnedCategoriesProvider.manageExpensePinnedCategoriesProvider,
      ),
    ];
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: PinnedCategoriesProvider.manageElevatedProvider,
        title: 'Pinned categories',
        leading: const CustomCloseButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_rounded),
            tooltip: 'Save',
            onPressed: () {
              Navigator.pop(context);
              ref
                  .read(pinnedCategoryPreferencesProvider.notifier)
                  .setString(json.encode(pinnedCategoryIds));
            },
          ),
        ],
      ),
      body: ScrollNotificationWrapper(
        provider: PinnedCategoriesProvider.manageElevatedProvider,
        child: CustomListView.async(
          asyncValue: ref.watch(PinnedCategoriesProvider.categoriesProvider),
          emptyText: 'No categories',
          builder: (context, index, category) => category.when(
            title: (isIncome) => Padding(
              padding: index == 0
                  ? EdgeInsets.zero
                  : const EdgeInsets.only(top: 8.0),
              child: TitleCard(
                title: '${isIncome ? 'Income' : 'Expense'} categories',
              ),
            ),
            value: (category) {
              final isSelected = pinnedCategoryIds.contains(category.id);
              return ManagePinnedCategoryTile(
                category: category,
                isSelected: isSelected,
                onTap: () => onChanged(
                  context: context,
                  read: ref.read,
                  isSelected: isSelected,
                  category: category,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
