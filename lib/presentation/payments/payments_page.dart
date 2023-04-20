import '../core_package/core_widget.dart';

import '../add_payment/add_payment_page.dart';
import 'components/payment_tile.dart';
import 'payments_provider.dart';
import 'package:flutter/material.dart';

class PaymentsPage extends StatelessWidget {
  static const route = 'payments-page';
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: PaymentsProvider.elevatedProvider,
        title: 'Payments',
        actions: [
          IconButton(
            tooltip: 'Add payment',
            onPressed: () => Navigator.pushNamed(context, AddPaymentPage.route),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: ScrollNotificationWrapper(
        provider: PaymentsProvider.elevatedProvider,
        builder: (context, ref, child) => CustomListView.async(
          firstChild: const SizedBox(height: 8),
          hasFab: true,
          asyncValue: ref.watch(PaymentsProvider.paymentsProvider),
          emptyText: 'No payments',
          builder: (context, index, payment) => PaymentTile(payment: payment),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add payment',
        onPressed: () => Navigator.pushNamed(context, AddPaymentPage.route),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
