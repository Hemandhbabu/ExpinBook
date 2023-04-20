import 'dart:convert';

import '../../domain/models/expin.dart';
import '../../domain/models/payment.dart';
import 'components/summary_card.dart';
import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/models/category.dart';
import '../../domain/models/expin_data.dart';
import '../../domain/models/payment_data.dart';
import '../../utils/my_datetime.dart';
import '../../utils/my_iterable.dart';
import '../utils/date_filter.dart';

part 'category_analysis_provider.g.dart';

class CategoryAnalysisProvider {
  const CategoryAnalysisProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final dateFilterProvider = StateProvider.autoDispose<DateFilter>(
      (ref) => throw UnimplementedError());
  static final categoryFilterProvider =
      StateProvider.autoDispose<Category>((ref) => throw UnimplementedError());
}

final _expinDatasProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(
    expinDataUseCasesProvider.select((e) => e.getAllExpinData.watchAll()),
  );
});
final _paymentsProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(
    paymentUseCasesProvider.select((e) => e.getAllPayment.watchAll()),
  );
});

@riverpod
AsyncValue<SummaryData> summaryData(
  SummaryDataRef ref, {
  required DateFilter filter,
  required int category,
}) {
  final expins = ref.watch(
    expinDatasFilterProvider(category: category, filter: filter).select(
      (value) => value.whenData(
        (expinDatas) => expinDatas.map((e) => e.expin).toList(),
      ),
    ),
  );
  return expins.merge(
    (expins) {
      final jsonList = [
        jsonEncode(filter.toJson()),
        jsonEncode(expins.map((e) => e.toJson()).toList()),
      ];
      final json = jsonEncode(jsonList);
      return ref.watch(_convertedSummaryDataProvider(json));
    },
  );
}

final _convertedSummaryDataProvider = FutureProvider.autoDispose.family(
  (ref, String json) => compute(_convertSummaryData, json),
);

SummaryData _convertSummaryData(String json) {
  final jsonList = (jsonDecode(json) as List).cast<String>();
  final dateFilter = DateFilter.fromJson(
    (jsonDecode(jsonList[0]) as Map).cast<String, dynamic>(),
  );
  final expins =
      (jsonDecode(jsonList[1]) as List).cast<String>().map(Expin.fromJson);
  final noOfDays = dateFilter.when(
    all: () {
      var first = DateTime.now();
      var last = DateTime(2000);
      for (var element in expins.map((e) => e.dateTime)) {
        if (element.isBefore(first)) first = element;
        if (element.isAfter(last)) last = element;
      }
      first = first.copyTimeOfDay(const TimeOfDay(hour: 0, minute: 0));
      last = last.copyTimeOfDay(const TimeOfDay(hour: 23, minute: 0));
      return last.difference(first).inDays + 1;
    },
    date: (date) => 1,
    month: (month) => DateTime.now().format('yM') == month.format('yM')
        ? month.day
        : month.monthMaxDays,
    year: (year) => DateTime.now().year == year.year
        ? year.noOfDaysThisYearTillToday
        : year.yearMaxDays,
    dateTimeRange: (range) =>
        range.end
            .copyTimeOfDay(const TimeOfDay(hour: 0, minute: 0))
            .difference(
              range.start.copyTimeOfDay(const TimeOfDay(hour: 0, minute: 0)),
            )
            .inDays +
        1,
  );
  final maxPerDay = expins
      .reduceToField(
        (item) => item.dateTime,
        (one, two) => one.format('yMd') == two.format('yMd'),
      )
      .map(
        (e) => expins
            .where(
              (element) => element.dateTime.format('yMd') == e.format('yMd'),
            )
            .map((e) => e.amount)
            .addition,
      )
      .max;
  return SummaryData(
    totalAmount: expins.map((e) => e.amount).addition,
    noOfDays: noOfDays,
    noOfTransactions: expins.length,
    maxPerDay: maxPerDay,
    maxPerTransaction: expins.map((e) => e.amount).max,
  );
}

@riverpod
AsyncValue<List<ExpinData>> expinDatasFilter(
  ExpinDatasFilterRef ref, {
  required DateFilter filter,
  required int category,
}) =>
    ref.watch(
      _expinDatasProvider.select(
        (value) => value.whenData(
          (value) => value
              .where(
                (e) =>
                    (e.expin.categoryId == category) &&
                    e.expin.dateTime.filter(filter),
              )
              .toList(),
        ),
      ),
    );

final _convertedDataProvider = FutureProvider.autoDispose.family(
  (ref, String json) => compute(_convertData, json),
);

@riverpod
AsyncValue<List<PaymentData>> paymentDatasFilter(
  PaymentDatasFilterRef ref, {
  required DateFilter filter,
  required int category,
}) =>
    ref
        .watch(expinDatasFilterProvider(category: category, filter: filter))
        .whenData((value) => value.map((e) => e.expin))
        .merge(
          (expins) => ref.watch(_paymentsProvider).merge(
            (payments) {
              final jsonList = [
                jsonEncode(filter.toJson()),
                jsonEncode(expins.map((e) => e.toJson()).toList()),
                jsonEncode(payments.map((e) => e.toJson()).toList()),
              ];
              return ref.watch(
                _convertedDataProvider(jsonEncode(jsonList)),
              );
            },
          ),
        );

Future<List<PaymentData>> _convertData(String json) async {
  final jsonList = (jsonDecode(json) as List).cast<String>();
  final filter = DateFilter.fromJson(
    (jsonDecode(jsonList[0]) as Map).cast<String, dynamic>(),
  );
  final expins = (jsonDecode(jsonList[1]) as List)
      .cast<String>()
      .map((e) => Expin.fromJson(e));
  final payments = (jsonDecode(jsonList[2]) as List)
      .cast<String>()
      .map((e) => Payment.fromJson(e));
  return payments
      .map(
        (e) {
          final filtered =
              expins.where((element) => element.paymentId == e.id).toList();
          if (filtered.isEmpty) return null;
          return PaymentData(
            payment: e,
            amount: filtered.map((e) => e.amount).addition,
            noOfTransactions: filtered.length,
            filter: filter,
            isIncome: filtered.first.isIncome,
          );
        },
      )
      .removeNulls
      .reduceToField(
        (item) => item.noOfTransactions <= 0 ? null : item,
        (one, two) => one.payment.id == two.payment.id,
      )
    ..sort((o, t) => o.payment.id!.compareTo(t.payment.id!))
    ..sort((o, t) => o.isIncome == t.isIncome
        ? 0
        : o.isIncome
            ? -1
            : 1);
}
