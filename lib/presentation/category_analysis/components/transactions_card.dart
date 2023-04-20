import '../../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/category.dart';
import '../../core/transaction_tile.dart';
import '../../transaction_overview/transaction_overview_page.dart';
import '../../transaction_overview/utils/transaction_overview_arg.dart';
import '../../utils/category_filter.dart';
import '../../utils/date_filter.dart';
import '../category_analysis_provider.dart';

class TransactionsCard extends ConsumerWidget {
  final DateFilter dateFilter;
  final Category category;
  const TransactionsCard({
    Key? key,
    required this.dateFilter,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncWidgetWrapper(
      asyncValue: ref.watch(
        expinDatasFilterProvider(category: category.id!, filter: dateFilter),
      ),
      builder: (context, expins) => Column(
        children: [
          TitleCard(
            title: 'Transactions (${expins.length})',
            trailing: expins.length > 5
                ? TextButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      TransactionOverviewPage.route,
                      arguments: TransactionOverviewArg(
                        dateFilter: dateFilter,
                        categoryFilter: CategoryFilter.category(category),
                      ),
                    ),
                    child: const Text('See all'),
                  )
                : null,
          ),
          ...expins.take(5).map(
                (e) => TransactionTile(expinData: e),
              ),
        ],
      ),
    );
  }
}
