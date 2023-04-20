import '../../category_analysis/category_analysis_page.dart';
import '../../category_analysis/utils/category_analysis_arg.dart';
import '../../utils/date_filter.dart';

import '../../core_package/core_widget.dart';

import '../../add_category/add_category_arg.dart';
import '../../add_category/add_category_page.dart';
import '../../add_category/add_category_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/category.dart';
import '../../utils/show_action_utils.dart';

class CategoryTile extends ConsumerWidget {
  final Category category;
  final bool isPinned;
  const CategoryTile({
    super.key,
    required this.category,
    required this.isPinned,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomTile(
      maxLines: 1,
      onTap: () => Navigator.pushNamed(
        context,
        AddCategoryPage.route,
        arguments: AddCategoryArg(category: category),
      ),
      onLongPress: () {
        final isBaseCategory = category.id == 1 || category.id == 6;
        showCustomAction(
          context,
          tile: this,
          TileActionData(
            actions: [
              const TileAction(
                icon: Icons.category_rounded,
                text: 'Analyse category',
                value: 0,
              ),
              if (!isBaseCategory)
                const TileAction(
                  icon: Icons.edit_rounded,
                  text: 'Edit category',
                  iconColor: Colors.blue,
                  tileColor: Colors.blue,
                  value: 1,
                ),
              if (!isBaseCategory)
                const TileAction(
                  icon: Icons.delete_rounded,
                  text: 'Delete category',
                  iconColor: Colors.red,
                  tileColor: Colors.red,
                  value: 2,
                ),
            ],
            valueChanged: (value) {
              if (value == 1) {
                Navigator.pushNamed(
                  context,
                  AddCategoryPage.route,
                  arguments: AddCategoryArg(editable: true, category: category),
                );
              } else if (value == 2) {
                AddCategoryProvider.delete(context, ref.read, category);
              } else if (value == 0) {
                Navigator.pushNamed(
                  context,
                  CategoryAnalysisPage.route,
                  arguments: CategoryAnalysisArg(
                    dateFilter: DateFilter.month(DateTime.now()),
                    category: category,
                  ),
                );
              }
            },
          ),
        );
      },
      padding: category.description?.isNotEmpty != true
          ? const EdgeInsets.symmetric(vertical: 5)
          : EdgeInsets.zero,
      leadingIcon: category.icon,
      leadingSymbol: category.symbol,
      leadingColor: category.color,
      title: category.name,
      subtitle: category.description,
      trailing: isPinned ? const Icon(Icons.push_pin_rounded, size: 20) : null,
    );
  }
}
