import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/models/expin_data.dart';
import '../../utils/base_extensions.dart';
import '../../utils/my_datetime.dart';
import '../../utils/my_iterable.dart';
import '../core_package/core_widget.dart';
import '../utils/expin_list_data.dart';
import 'income_expense_card.dart';
import 'transaction_tile.dart';

final _convertedDataProvider = FutureProvider.autoDispose.family(
  (ref, String json) => compute(_convertData, json),
);

List<ExpinData> _buildJsonToExpinDatas(String json) {
  final strings = (jsonDecode(json) as List).cast<Map<String, dynamic>>();
  return strings.map((e) => ExpinData.fromJson(e)).toList();
}

String _buildExpinDatasToJson(List<ExpinData> datas) {
  final strings = datas.map((e) => e.toJson()).toList();
  return jsonEncode(strings);
}

Future<List<ExpinListData>> _convertData(String json) async {
  final format = DateFormat.yMd().format;
  final data = _buildJsonToExpinDatas(json);
  return data.isEmpty
      ? <ExpinListData>[]
      : data
          .reduceToField(
          (item) => item.expin.dateTime,
          (one, two) => format(one) == format(two),
        )
          .map(
          (e) {
            final expins = data
                .where((element) => format(element.expin.dateTime) == format(e))
                .map((e) => ExpinListData.data(e));
            return [
              ExpinListData.date(e, expins.length),
              ...expins,
            ];
          },
        ).reduce((o, t) => [...o, ...t]);
}

class ExpinListView extends ConsumerWidget {
  final bool useIncomeCard;
  final bool hasFab;
  final bool showNoOfTransactions;
  final bool showSavings;
  final bool showTransfers;
  final AutoDisposeStreamProvider<List<ExpinData>> provider;
  const ExpinListView({
    super.key,
    required this.provider,
    this.useIncomeCard = false,
    this.hasFab = false,
    this.showNoOfTransactions = false,
    this.showSavings = false,
    this.showTransfers = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomListView<ExpinListData>.async(
      asyncValue: ref.watch(provider).merge(
            (data) =>
                ref.watch(_convertedDataProvider(_buildExpinDatasToJson(data))),
          ),
      emptyText: 'No transactions',
      hasFab: hasFab,
      firstChild: useIncomeCard
          ? IncomeExpenseCard.fromExpinDatas(
              showNoOfTransactions: showNoOfTransactions,
              expins: provider,
              showSavings: showSavings,
              showTransfers: showTransfers,
            )
          : null,
      builder: (context, index, data) => data.when(
        date: (date, count) => Padding(
          padding: index == 0 ? EdgeInsets.zero : const EdgeInsets.only(top: 8),
          child: TitleCard(
            title: date.dateOrMonthFormat(false, alsoWeek: true),
          ),
        ),
        data: (data) => TransactionTile(expinData: data, showTimeOnly: true),
      ),
    );
  }
}
