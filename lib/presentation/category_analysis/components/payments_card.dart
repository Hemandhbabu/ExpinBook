import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/category.dart';
import '../../core/payment_transactions_tile.dart';
import '../../core_package/core_widget.dart';
import '../../utils/date_filter.dart';
import '../category_analysis_provider.dart';

class PaymentsCard extends ConsumerWidget {
  final DateFilter dateFilter;
  final Category category;
  const PaymentsCard({
    Key? key,
    required this.dateFilter,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncWidgetWrapper(
      asyncValue: ref.watch(
        paymentDatasFilterProvider(category: category.id!, filter: dateFilter),
      ),
      builder: (context, payments) => Column(
        children: [
          const TitleCard(title: 'Payments'),
          ...payments.map(
            (e) => PaymentTransactionsTile(paymentData: e, category: category),
          ),
        ],
      ),
    );
  }
}
