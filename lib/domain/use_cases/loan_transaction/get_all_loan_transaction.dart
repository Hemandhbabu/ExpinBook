import '../../models/loan_transaction.dart';
import '../../repositories/loan_transaction_repository.dart';

class GetAllLoanTransaction {
  final LoanTransactionRepository _repository;

  const GetAllLoanTransaction(this._repository);

  Future<List<LoanTransaction>> findAllWithLoanId(int loanId) =>
      _repository.findAllWithLoanId(loanId);

  Stream<List<LoanTransaction>> watchAllWithLoanId(int loanId) =>
      _repository.watchAllWithLoanId(loanId);

  Future<List<LoanTransaction>> findAll() => _repository.findAll();
  Stream<List<LoanTransaction>> watchAll() => _repository.watchAll();
}
