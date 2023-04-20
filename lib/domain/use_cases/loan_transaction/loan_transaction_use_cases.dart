import 'get_all_loan_transaction.dart';
import 'get_loan_transaction.dart';
import 'modify_loan_transaction.dart';

class LoanTransactionUseCases {
  final ModifyLoanTransaction modifyLoanTransaction;
  final GetLoanTransaction getLoanTransaction;
  final GetAllLoanTransaction getAllLoanTransaction;

  const LoanTransactionUseCases({
    required this.modifyLoanTransaction,
    required this.getLoanTransaction,
    required this.getAllLoanTransaction,
  });
}
