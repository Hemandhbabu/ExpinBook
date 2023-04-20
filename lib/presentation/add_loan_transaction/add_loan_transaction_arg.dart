import '../../domain/models/loan_transaction.dart';

class AddLoanTransactionArg {
  final bool editable;
  final int loanId;
  final LoanTransaction? transaction;

  const AddLoanTransactionArg({
    this.editable = false,
    required this.loanId,
    this.transaction,
  });
}
