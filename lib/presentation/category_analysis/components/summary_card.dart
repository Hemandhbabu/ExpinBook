import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/category.dart';
import '../../core/currency_text.dart';
import '../../core_package/core_widget.dart';
import '../../utils/date_filter.dart';
import '../category_analysis_provider.dart';

const _labelStyle = TextStyle(fontSize: 16);
const _titleStyle = TextStyle(fontSize: 16.5);
const _valueStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

class SummaryCard extends ConsumerWidget {
  final DateFilter dateFilter;
  final Category category;
  const SummaryCard({
    Key? key,
    required this.dateFilter,
    required this.category,
  }) : super(key: key);

  Widget buildAnalysisTile(String title, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 32),
          Opacity(
            opacity: 0.8,
            child: Text(title, style: _labelStyle),
          ),
          const Spacer(),
          CurrencyText(value, style: _valueStyle),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncWidgetWrapper(
      asyncValue: ref.watch(
        summaryDataProvider(category: category.id!, filter: dateFilter),
      ),
      builder: (context, summaryData) => Card(
        margin: const EdgeInsets.fromLTRB(12, 4, 12, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            ListTile(
              dense: true,
              title: const Text('Number of transactions', style: _labelStyle),
              trailing: Text(
                '${summaryData.noOfTransactions}',
                style: _valueStyle,
              ),
            ),
            ListTile(
              dense: true,
              title: const Text('Number of days', style: _labelStyle),
              trailing: Text('${summaryData.noOfDays}', style: _valueStyle),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'Average ${category.isIncome ? 'income' : 'expense'}',
                style: _titleStyle,
              ),
            ),
            buildAnalysisTile('Per day', summaryData.averagePerDay),
            buildAnalysisTile(
              'Per transaction',
              summaryData.averagePerTransaction,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Text(
                'Maximum ${category.isIncome ? 'income' : 'expense'}',
                style: _titleStyle,
              ),
            ),
            buildAnalysisTile('Per day', summaryData.maxPerDay),
            buildAnalysisTile('Per transaction', summaryData.maxPerTransaction),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class SummaryData {
  final double totalAmount;
  final int noOfDays;
  final int noOfTransactions;
  final double maxPerDay;
  final double maxPerTransaction;

  const SummaryData({
    required this.totalAmount,
    required this.noOfDays,
    required this.noOfTransactions,
    required this.maxPerDay,
    required this.maxPerTransaction,
  });

  double get averagePerDay => noOfDays > 0 ? (totalAmount / noOfDays) : 0.0;
  double get averagePerTransaction =>
      noOfTransactions > 0 ? (totalAmount / noOfTransactions) : 0.0;
}
