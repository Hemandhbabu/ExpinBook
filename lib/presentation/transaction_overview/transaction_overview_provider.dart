import '../../provider/use_cases_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/expin_data.dart';
import '../../utils/my_datetime.dart';
import '../utils/category_filter.dart';
import '../utils/date_filter.dart';
import '../utils/payment_filter.dart';

class TransactionOverviewProvider {
  const TransactionOverviewProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final dateFilterProvider = StateProvider.autoDispose(
    (ref) => DateFilter.month(DateTime.now()),
  );

  static final categoryFilterProvider = StateProvider.autoDispose(
    (ref) => const CategoryFilter.all(),
  );

  static final paymentFilterProvider = StateProvider.autoDispose(
    (ref) => const PaymentFilter.all(),
  );

  static final customExpinDatasProvider =
      StreamProvider.autoDispose(filterDatas);

  static bool _filter(
    ExpinData data,
    DateFilter date,
    CategoryFilter category,
    PaymentFilter payment,
  ) {
    final isDate = data.expin.dateTime.filter(date);
    if (!isDate) return false;
    final isCategory = category.when(
      all: () => true,
      income: () => data.expin.isIncome,
      expense: () => data.expin.isExpense,
      transfer: () => data.expin.isTransfer,
      category: (category) => category.id == data.expin.categoryId,
      categories: (categories) =>
          categories.map((e) => e.id).contains(data.expin.categoryId),
    );
    if (!isCategory) return false;
    final isPayment = payment.when(
      all: () => true,
      payment: (payment) => data.when(
        expin: (element) => payment.id == element.paymentId,
        transfer: (element) =>
            payment.id == element.fromPaymentId ||
            payment.id == element.toPaymentId,
      ),
      payments: (payments) => data.when(
        expin: (element) =>
            payments.map((e) => e.id).contains(element.paymentId),
        transfer: (element) =>
            payments.map((e) => e.id).contains(element.fromPaymentId) ||
            payments.map((e) => e.id).contains(element.toPaymentId),
      ),
    );
    if (!isPayment) return false;
    return isDate && isCategory && isPayment;
  }

  static Stream<List<ExpinData>> filterDatas(
      AutoDisposeStreamProviderRef<List<ExpinData>> ref) {
    final date = ref.watch(dateFilterProvider);
    final category = ref.watch(categoryFilterProvider);
    final payment = ref.watch(paymentFilterProvider);
    return ref.watch(
      expinDataUseCasesProvider.select(
        (value) => value.getAllExpinData.watchAll().map(
              (value) => value
                  .where((element) => _filter(element, date, category, payment))
                  .toList(),
            ),
      ),
    );
  }
}
