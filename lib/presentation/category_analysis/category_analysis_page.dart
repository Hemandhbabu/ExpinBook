import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/category.dart';
import '../core/income_expense_card.dart';
import '../core_package/core_widget.dart';
import '../utils/date_filter.dart';
import 'category_analysis_provider.dart';
import 'components/category_analysis_filter_bar.dart';
import 'components/category_analysis_filter_button.dart';
import 'components/payments_card.dart';
import 'components/summary_card.dart';
import 'components/transactions_card.dart';

class CategoryAnalysisPage extends StatelessWidget {
  static const route = 'category-analysis-page';
  final DateFilter dateFilter;
  final Category category;
  const CategoryAnalysisPage({
    Key? key,
    required this.dateFilter,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        CategoryAnalysisProvider.categoryFilterProvider
            .overrideWith((ref) => category),
        CategoryAnalysisProvider.dateFilterProvider
            .overrideWith((ref) => dateFilter),
      ],
      child: Scaffold(
        appBar: CustomAppBar.elevated(
          provider: CategoryAnalysisProvider.elevatedProvider,
          title: 'Category analysis',
          bottom: const CategoryAnalysisFilterBar(),
          actions: const [CategoryAnalysisFilterButton()],
        ),
        body: ScrollNotificationWrapper(
          provider: CategoryAnalysisProvider.elevatedProvider,
          builder: (context, ref, child) {
            final category =
                ref.watch(CategoryAnalysisProvider.categoryFilterProvider);
            final dateFilter =
                ref.watch(CategoryAnalysisProvider.dateFilterProvider);
            return AsyncWidgetWrapper(
              asyncValue: ref.watch(
                expinDatasFilterProvider(
                        category: category.id!, filter: dateFilter)
                    .select(
                        (value) => value.whenData((value) => value.isEmpty)),
              ),
              loadingBuilder: (context) => const LoadingList(),
              builder: (context, isEmpty) => isEmpty
                  ? CenterText('No transactions in\n"${category.name}"')
                  : ListView(
                      children: [
                        const SizedBox(height: 4),
                        IncomeExpenseCard.fromExpinDatas(
                          expins: expinDatasFilterProvider(
                              category: category.id!, filter: dateFilter),
                        ),
                        const SizedBox(height: 4),
                        TransactionsCard(
                          category: category,
                          dateFilter: dateFilter,
                        ),
                        const SizedBox(height: 16),
                        PaymentsCard(
                          dateFilter: dateFilter,
                          category: category,
                        ),
                        const SizedBox(height: 16),
                        const TitleCard(title: 'Summary'),
                        SummaryCard(
                          dateFilter: dateFilter,
                          category: category,
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
