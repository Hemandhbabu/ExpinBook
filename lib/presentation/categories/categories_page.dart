import '../../provider/preferences_provider.dart';

import '../core_package/core_widget.dart';
import 'package:flutter/material.dart';

import '../add_category/add_category_page.dart';
import 'categories_provider.dart';
import 'components/category_tile.dart';

class CategoriesPage extends StatelessWidget {
  static const route = 'categories-page';
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: CategoriesProvider.elevatedProvider,
        title: 'Categories',
        actions: [
          IconButton(
            tooltip: 'Add category',
            onPressed: () =>
                Navigator.pushNamed(context, AddCategoryPage.route),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: ScrollNotificationWrapper(
        provider: CategoriesProvider.elevatedProvider,
        builder: (context, ref, child) {
          final pinned = ref.watch(pinnedCategoryIdsProvider);
          return CustomListView.async(
            hasFab: true,
            asyncValue: ref.watch(CategoriesProvider.categoriesProvider),
            emptyText: 'No categories',
            builder: (context, index, category) => category.when(
              title: (isIncome) => Padding(
                padding:
                    isIncome ? EdgeInsets.zero : const EdgeInsets.only(top: 12),
                child: TitleCard(
                  title: '${isIncome ? 'Income' : 'Expense'} categories',
                ),
              ),
              value: (category) => CategoryTile(
                category: category,
                isPinned: pinned.contains(category.id),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add category',
        onPressed: () => Navigator.pushNamed(context, AddCategoryPage.route),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
