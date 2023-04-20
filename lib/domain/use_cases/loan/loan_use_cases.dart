import 'get_all_loan.dart';
import 'get_loan.dart';
import 'modify_loan.dart';

class LoanUseCases {
  final ModifyLoan modifyLoan;
  final GetLoan getLoan;
  final GetAllLoan getAllLoan;

  const LoanUseCases({
    required this.modifyLoan,
    required this.getLoan,
    required this.getAllLoan,
  });
}
