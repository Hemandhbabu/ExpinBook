import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/loan.dart';
import '../../domain/models/loan_transaction.dart';
import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import '../loan_detail/loan_detail_data.dart';

class LoansProvider {
  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final _loansProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(loanUseCasesProvider).getAllLoan.watchAll(),
  );

  static final _transactionsProvider = StreamProvider.autoDispose(
    (ref) => ref
        .watch(loanTransactionUseCasesProvider)
        .getAllLoanTransaction
        .watchAll(),
  );

  static final loansProvider = Provider.autoDispose(
    (ref) {
      final loans = ref.watch(_loansProvider);
      final transactions = ref.watch(_transactionsProvider);
      return loans.merge(
        (loans) => transactions.merge(
          (transactions) {
            final jsonList = [
              jsonEncode(loans.map((e) => e.toJson()).toList()),
              jsonEncode(transactions.map((e) => e.toJson()).toList()),
            ];
            final json = jsonEncode(jsonList);
            return ref.watch(_convertedDataProvider(json));
          },
        ),
      );
    },
  );

  static final _convertedDataProvider = FutureProvider.autoDispose.family(
    (ref, String json) => compute(_convertData, json),
  );
}

Future<List<LoanDetailData>> _convertData(String json) async {
  final jsonList = (jsonDecode(json) as List).cast<String>();
  final loans =
      (jsonDecode(jsonList[0]) as List).cast<String>().map(Loan.fromJson);
  final transactions = (jsonDecode(jsonList[1]) as List)
      .cast<String>()
      .map(LoanTransaction.fromJson);
  return loans
      .map(
        (e) => LoanDetailData(
          loan: e,
          transactions:
              transactions.where((element) => element.loanId == e.id).toList(),
        ),
      )
      .toList();
}
