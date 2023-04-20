import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/models/loan_transaction.dart';

part 'loan_transaction_list_data.freezed.dart';

@freezed
class LoanTransactionListData with _$LoanTransactionListData {
  const factory LoanTransactionListData.date(DateTime dateTime, int count) =
      _Date;
  const factory LoanTransactionListData.data(LoanTransaction transaction) =
      _Data;
}
