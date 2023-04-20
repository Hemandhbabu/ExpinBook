import '../add_category/add_category_arg.dart';
import '../add_category/add_category_page.dart';
import '../utils/show_action_utils.dart';

import '../core_package/core_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/models/category_data.dart';
import '../category_analysis/category_analysis_page.dart';
import '../category_analysis/utils/category_analysis_arg.dart';
import 'currency_text.dart';

class CategoryTransactionsTile extends StatelessWidget {
  final CategoryData categoryData;
  const CategoryTransactionsTile({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    final category = categoryData.category;
    final amount = categoryData.amount;
    final count = categoryData.noOfTransactions;
    return CustomTile(
      onTap: () => Navigator.pushNamed(
        context,
        CategoryAnalysisPage.route,
        arguments: CategoryAnalysisArg(
          dateFilter: categoryData.filter,
          category: category,
        ),
      ),
      onLongPress: () => showCustomAction(
        context,
        tile: this,
        TileActionData(
          actions: const [
            TileAction(
              text: 'Category details',
              value: 0,
              icon: Icons.open_in_new_rounded,
            ),
          ],
          valueChanged: (value) {
            if (value == 0) {
              Navigator.pushNamed(
                context,
                AddCategoryPage.route,
                arguments: AddCategoryArg(category: category),
              );
            }
          },
        ),
      ),
      leadingIcon: category.icon,
      leadingSymbol: category.symbol,
      leadingColor: category.color,
      title: category.name,
      maxLines: 1,
      subtitle: count == 0
          ? 'No transactions'
          : count == 1
              ? '1 transaction'
              : '$count transactions',
      trailing: CurrencyText(
        (category.isIncome ? 1 : -1) * amount,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: amount == 0
              ? Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.5)
              : category.isIncome
                  ? Colors.green
                  : null,
        ),
      ),
    );
  }
}
