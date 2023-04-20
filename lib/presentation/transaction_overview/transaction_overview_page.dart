import '../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../core/expin_list_view.dart';
import '../utils/category_filter.dart';
import '../utils/date_filter.dart';
import '../utils/payment_filter.dart';
import 'components/transaction_filter_bar.dart';
import 'components/transaction_filter_button.dart';
import 'transaction_overview_provider.dart';

class TransactionOverviewPage extends StatelessWidget {
  static const route = 'transaction-overview-page';
  const TransactionOverviewPage({
    super.key,
    required this.dateFilter,
    required this.categoryFilter,
    required this.paymentFilter,
  });

  final DateFilter? dateFilter;
  final CategoryFilter? categoryFilter;
  final PaymentFilter? paymentFilter;

  List<Override> overrides() {
    final overrides = <Override>[];

    final dateFilter = this.dateFilter;
    final categoryFilter = this.categoryFilter;
    final paymentFilter = this.paymentFilter;

    bool changed = false;

    if (dateFilter != null) {
      changed = true;
      overrides.add(
        TransactionOverviewProvider.dateFilterProvider
            .overrideWith((ref) => dateFilter),
      );
    }
    if (categoryFilter != null) {
      changed = true;
      overrides.add(
        TransactionOverviewProvider.categoryFilterProvider
            .overrideWith((ref) => categoryFilter),
      );
    }
    if (paymentFilter != null) {
      changed = true;
      overrides.add(
        TransactionOverviewProvider.paymentFilterProvider
            .overrideWith((ref) => paymentFilter),
      );
    }

    if (changed) {
      overrides.add(
        TransactionOverviewProvider.customExpinDatasProvider
            .overrideWith(TransactionOverviewProvider.filterDatas),
      );
    }

    return overrides;
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: overrides(),
      child: Scaffold(
        appBar: CustomAppBar.elevated(
          provider: TransactionOverviewProvider.elevatedProvider,
          title: 'Transactions overview',
          bottom: const TransactionFilterBar(),
          actions: const [TransactionFilterButton()],
        ),
        body: ScrollNotificationWrapper(
          provider: TransactionOverviewProvider.elevatedProvider,
          builder: (context, ref, child) => ExpinListView(
            useIncomeCard: true,
            showNoOfTransactions: true,
            showTransfers: ref.watch(
              TransactionOverviewProvider.categoryFilterProvider
                  .select((value) => value.isTransfer),
            ),
            provider: TransactionOverviewProvider.customExpinDatasProvider,
            showSavings: ref.watch(
              TransactionOverviewProvider.categoryFilterProvider
                  .select((value) => value.hasAll),
            ),
          ),
        ),
      ),
    );
  }
}
