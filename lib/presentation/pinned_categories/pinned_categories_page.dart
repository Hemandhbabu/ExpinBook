import '../core_package/core_widget.dart';

import 'components/manage_pinned_categories.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/category_transactions_tile.dart';
import 'pinned_categories_provider.dart';

class PinnedCategoriesPage extends ConsumerWidget {
  static const route = 'pinned-categories-page';
  const PinnedCategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar.elevated(
        title: 'Pinned categories',
        provider: PinnedCategoriesProvider.elevatedProvider,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, ManagePinnedCategories.route),
            icon: const Icon(Icons.edit_rounded),
          ),
        ],
      ),
      body: CustomListView.async(
        emptyText: 'No pinned categories',
        asyncValue:
            ref.watch(PinnedCategoriesProvider.pinnedCategoriesProvider),
        builder: (context, index, category) => category.when(
          title: (isIncome) => Padding(
            padding:
                index == 0 ? EdgeInsets.zero : const EdgeInsets.only(top: 8.0),
            child: TitleCard(
              title: '${isIncome ? 'Income' : 'Expense'} categories',
            ),
          ),
          value: (category) => CategoryTransactionsTile(categoryData: category),
        ),
      ),
    );
  }
}
