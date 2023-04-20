import '../../utils/theme.dart';
import '../core_package/core_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/my_iterable.dart';
import '../core/income_expense_card.dart';
import '../core/payment_transactions_tile.dart';
import '../utils/payment_filter.dart';
import 'components/payment_chart.dart';
import 'components/payment_overview_filter_bar.dart';
import 'components/payment_overview_filter_button.dart';
import 'payment_overview_provider.dart';

class PaymentOverviewPage extends StatelessWidget {
  static const route = 'payment-overview-page';
  const PaymentOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: PaymentOverviewProvider.elevatedProvider,
        title: 'Payments overview',
        bottom: const PaymentOverviewFilterBar(),
        actions: const [PaymentOverviewFilterButton()],
      ),
      body: ScrollNotificationWrapper(
        provider: PaymentOverviewProvider.elevatedProvider,
        builder: (context, ref, child) => AsyncWidgetWrapper(
          asyncValue:
              ref.watch(PaymentOverviewProvider.paymentsOverviewProvider),
          loadingBuilder: (context) => const LoadingList(),
          builder: (context, paymentDatas) => CustomListView(
            items: paymentDatas,
            animateListChanges: true,
            firstChild: IncomeExpenseCard(
              expins: PaymentOverviewProvider.filteredExpinsProvider,
              showSavings: true,
            ),
            emptyText: 'Select a payment to analyse',
            emptyWidgetBuilder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CenterText('No payments selected'),
                const SizedBox(width: double.infinity, height: 4),
                ElevatedButton(
                  onPressed: () => PaymentOverviewFilterButton.selectPayment(
                    context: context,
                    payment: const PaymentFilter.payments([]),
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
                  child: const Text('Select payment'),
                ),
              ],
            ),
            builder: (context, index, payment) => payment.when(
              title: (isIncome) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TitleCard(
                      title: '${isIncome ? 'Income' : 'Expense'} payments',
                    ),
                  ),
                  PaymentChart(
                    isIncome: isIncome,
                    data: paymentDatas.reduceToField(
                      (item) => item.when(
                        title: (isIncome) => null,
                        value: (e) => e.isIncome != isIncome ? null : e,
                      ),
                      (one, two) => one.payment.id == two.payment.id,
                    ),
                  ),
                ],
              ),
              value: (payment) => PaymentTransactionsTile(paymentData: payment),
            ),
          ),
        ),
      ),
    );
  }
}
