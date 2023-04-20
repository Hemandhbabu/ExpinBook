import 'dart:convert';

import 'package:flutter/foundation.dart' show compute;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/expin.dart';
import '../../domain/models/payment.dart';
import '../../domain/models/payment_data.dart';
import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import '../../utils/my_datetime.dart';
import '../../utils/my_iterable.dart';
import '../utils/date_filter.dart';
import '../utils/payment_filter.dart';
import '../utils/type_filter_list_data.dart';

class PaymentOverviewProvider {
  const PaymentOverviewProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final dateFilterProvider = StateProvider.autoDispose(
    (ref) => DateFilter.month(DateTime.now()),
  );

  static final paymentFilterProvider = StateProvider.autoDispose(
    (ref) => const PaymentFilter.payments([]),
  );

  static final filteredExpinsProvider = StreamProvider.autoDispose((ref) {
    final date = ref.watch(dateFilterProvider);
    final payment = ref.watch(paymentFilterProvider);
    return ref.watch(
      expinUseCasesProvider.select(
        (value) => value.getAllExpin.watchAll().map(
              (value) => value
                  .where(
                    (e) =>
                        e.dateTime.filter(date) &&
                        payment.when(
                          all: () => true,
                          payment: (payment) => payment.id == e.paymentId,
                          payments: (payments) =>
                              payments.map((e) => e.id).contains(e.paymentId),
                        ),
                  )
                  .toList(),
            ),
      ),
    );
  });

  static final _paymentsProvider = StreamProvider.autoDispose(
    (ref) => ref
        .watch(paymentUseCasesProvider.select((value) => value.getAllPayment))
        .watchAll(),
  );

  static final paymentsOverviewProvider = Provider.autoDispose((ref) {
    final date = ref.watch(dateFilterProvider);
    final payment = ref.watch(paymentFilterProvider);
    final expins = ref.watch(filteredExpinsProvider);
    final payments = ref.watch(_paymentsProvider);
    return expins.merge(
      (expins) => payments.merge(
        (payments) {
          final jsonList = [
            jsonEncode(date.toJson()),
            jsonEncode(payment.toJson()),
            jsonEncode(expins.map((e) => e.toJson()).toList()),
            jsonEncode(payments.map((e) => e.toJson()).toList()),
          ];
          final json = jsonEncode(jsonList);
          return ref.watch(_convertedDataProvider(json));
        },
      ),
    );
  });

  static final _convertedDataProvider = FutureProvider.autoDispose.family(
    (ref, String json) => compute(_convertData, json),
  );
}

List<TypeFilterListData<PaymentData>> _convertData(String json) {
  final jsonList = (jsonDecode(json) as List).cast<String>();
  final date = DateFilter.fromJson(
    (jsonDecode(jsonList[0]) as Map).cast<String, dynamic>(),
  );
  final payment = PaymentFilter.fromJson(
    (jsonDecode(jsonList[1]) as Map).cast<String, dynamic>(),
  );
  final expins = (jsonDecode(jsonList[2]) as List)
      .cast<String>()
      .map((e) => Expin.fromJson(e));
  final payments = (jsonDecode(jsonList[3]) as List)
      .cast<String>()
      .map((e) => Payment.fromJson(e));
  final paymentDatas = payments
      .where(
    (element) => payment.when(
      all: () => true,
      payment: (payment) => payment.id == element.id,
      payments: (payments) => payments.map((e) => e.id).contains(element.id),
    ),
  )
      .map(
    (e) {
      final list =
          expins.where((element) => element.paymentId == e.id).toList();
      list.sort((o, t) => t.paymentId.compareTo(t.paymentId));
      final income =
          list.where((element) => element.isIncome).map((e) => e.amount);
      final expense =
          list.where((element) => element.isExpense).map((e) => e.amount);
      return [
        PaymentData(
          payment: e,
          isIncome: true,
          amount: income.addition,
          noOfTransactions: income.length,
          filter: date,
        ),
        PaymentData(
          payment: e,
          isIncome: false,
          amount: expense.addition,
          noOfTransactions: expense.length,
          filter: date,
        ),
      ];
    },
  );
  final datas = <PaymentData>[];
  for (var element in paymentDatas) {
    for (var item in element) {
      datas.add(item);
    }
  }
  final income = datas.where((element) => element.isIncome).toList();
  income.sort((o, t) => t.amount.compareTo(o.amount));
  final expense = datas.where((element) => !element.isIncome).toList();
  expense.sort((o, t) => t.amount.compareTo(o.amount));
  return <TypeFilterListData<PaymentData>>[
    if (income.isNotEmpty) const TypeFilterListData.title(true),
    ...income.map((e) => TypeFilterListData.value(e)),
    if (expense.isNotEmpty) const TypeFilterListData.title(false),
    ...expense.map((e) => TypeFilterListData.value(e)),
  ];
}
