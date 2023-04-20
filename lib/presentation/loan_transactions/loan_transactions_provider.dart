import 'dart:convert';

import 'package:flutter/foundation.dart' show compute;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/models/loan_transaction.dart';
import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import '../../utils/my_iterable.dart';
import 'utils/loan_transaction_list_data.dart';

class LoanTransactionsProvider {
  const LoanTransactionsProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final _transactionsProvider = StreamProvider.autoDispose.family(
    (ref, int id) => ref
        .watch(loanTransactionUseCasesProvider)
        .getAllLoanTransaction
        .watchAllWithLoanId(id),
  );

  static final loanTransactionsProvider = Provider.autoDispose.family(
    (ref, int id) => ref.watch(_transactionsProvider(id)).merge(
      (transactions) {
        final json = _buildLoanTransactionsToJson(transactions);
        return ref.watch(_convertedDataProvider(json));
      },
    ),
  );

  static final _convertedDataProvider = FutureProvider.autoDispose.family(
    (ref, String json) => compute(_convertData, json),
  );
}

List<LoanTransaction> _buildJsonToLoanTransactions(String json) {
  final strings = (jsonDecode(json) as List).cast<String>();
  return strings.map((e) => LoanTransaction.fromJson(e)).toList();
}

String _buildLoanTransactionsToJson(List<LoanTransaction> datas) {
  final strings = datas.map((e) => e.toJson()).toList();
  return jsonEncode(strings);
}

Future<List<LoanTransactionListData>> _convertData(String json) async {
  final format = DateFormat.yMd().format;
  final data = _buildJsonToLoanTransactions(json);
  if (data.isEmpty) return [];
  return data
      .reduceToField(
    (item) => item.dateTime,
    (one, two) => format(one) == format(two),
  )
      .map(
    (e) {
      final transactions = data
          .where((element) => format(element.dateTime) == format(e))
          .map((e) => LoanTransactionListData.data(e));
      return [
        LoanTransactionListData.date(e, transactions.length),
        ...transactions,
      ];
    },
  ).reduce((o, t) => [...o, ...t]);
}
