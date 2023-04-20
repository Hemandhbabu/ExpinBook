import '../../utils/category_filter.dart';
import '../../utils/date_filter.dart';
import '../../utils/payment_filter.dart';

class TransactionOverviewArg {
  final DateFilter? dateFilter;
  final CategoryFilter? categoryFilter;
  final PaymentFilter? paymentFilter;

  const TransactionOverviewArg({
    this.dateFilter,
    this.categoryFilter,
    this.paymentFilter,
  });
}
