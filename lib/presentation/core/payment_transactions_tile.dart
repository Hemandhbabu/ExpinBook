import '../core_package/core_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/models/category.dart';
import '../../domain/models/payment_data.dart';
import '../transaction_overview/transaction_overview_page.dart';
import '../transaction_overview/utils/transaction_overview_arg.dart';
import '../utils/category_filter.dart';
import '../utils/payment_filter.dart';
import 'currency_text.dart';

class PaymentTransactionsTile extends StatelessWidget {
  final PaymentData paymentData;
  final Category? category;
  const PaymentTransactionsTile({
    super.key,
    required this.paymentData,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    final payment = paymentData.payment;
    final amount = paymentData.amount;
    final count = paymentData.noOfTransactions;
    final category = this.category;
    final isIncome = paymentData.isIncome;
    return CustomTile(
      onTap: () => Navigator.pushNamed(
        context,
        TransactionOverviewPage.route,
        arguments: TransactionOverviewArg(
          dateFilter: paymentData.filter,
          categoryFilter: category != null
              ? CategoryFilter.category(category)
              : isIncome
                  ? const CategoryFilter.income()
                  : const CategoryFilter.expense(),
          paymentFilter: PaymentFilter.payment(payment),
        ),
      ),
      leadingIcon: payment.mode.icon,
      leadingColor: payment.color,
      maxLines: 1,
      title: payment.name,
      subtitle: count == 0
          ? 'No transactions'
          : count == 1
              ? '1 transaction'
              : '$count transactions',
      trailing: CurrencyText(
        (isIncome ? 1 : -1) * amount,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w500,
          color: amount == 0
              ? Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.5)
              : isIncome
                  ? Colors.green
                  : null,
        ),
      ),
    );
  }
}
