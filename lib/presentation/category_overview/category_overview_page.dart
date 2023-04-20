import '../../utils/theme.dart';

import '../core_package/core_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/my_iterable.dart';
import '../core/category_transactions_tile.dart';
import '../core/income_expense_card.dart';
import '../utils/category_filter.dart';
import 'category_overview_provider.dart';
import 'components/category_chart.dart';
import 'components/category_overview_filter_bar.dart';
import 'components/category_overview_filter_button.dart';

class CategoryOverviewPage extends StatelessWidget {
  static const route = 'category-overview-page';
  const CategoryOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: CategoryOverviewProvider.elevatedProvider,
        title: 'Categories overview',
        bottom: const CategoryOverviewFilterBar(),
        actions: const [CategoryOverviewFilterButton()],
      ),
      body: ScrollNotificationWrapper(
        provider: CategoryOverviewProvider.elevatedProvider,
        builder: (context, ref, child) => AsyncWidgetWrapper(
          asyncValue:
              ref.watch(CategoryOverviewProvider.categoriesOverviewProvider),
          loadingBuilder: (context) => const LoadingList(),
          builder: (context, categoryDatas) => CustomListView(
            items: categoryDatas,
            animateListChanges: true,
            emptyText: 'Select a category to analyse',
            emptyWidgetBuilder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CenterText('No categories selected'),
                const SizedBox(width: double.infinity, height: 4),
                ElevatedButton(
                  onPressed: () => CategoryOverviewFilterButton.selectCategory(
                    context: context,
                    category: const CategoryFilter.categories([]),
                    read: ref.read,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                    foregroundColor: Colors.white,
                    shape: shape,
                  ),
                  child: const Text('Select category'),
                ),
              ],
            ),
            firstChild: IncomeExpenseCard(
              expins: CategoryOverviewProvider.filteredExpinsProvider,
              showSavings: ref.watch(
                CategoryOverviewProvider.categoryFilterProvider
                    .select((value) => value.hasAll),
              ),
            ),
            builder: (context, index, category) => category.when(
              title: (isIncome) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TitleCard(
                      title: '${isIncome ? 'Income' : 'Expense'} categories',
                    ),
                  ),
                  CategoryChart(
                    isIncome: isIncome,
                    data: categoryDatas.reduceToField(
                      (item) => item.when(
                        title: (isIncome) => null,
                        value: (value) => value,
                      ),
                      (one, two) => one.category.id == two.category.id,
                    ),
                  ),
                ],
              ),
              value: (category) =>
                  CategoryTransactionsTile(categoryData: category),
            ),
          ),
        ),
      ),
    );
  }
}
