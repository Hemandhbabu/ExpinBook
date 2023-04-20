import '../../models/loan_transaction.dart';
import '../../repositories/loan_transaction_repository.dart';

class GetLoanTransaction {
  final LoanTransactionRepository _repository;

  const GetLoanTransaction(this._repository);

  Future<LoanTransaction?> findWithId(int id) => _repository.findWithId(id);

  Stream<LoanTransaction?> watchWithId(int id) => _repository.watchWithId(id);
}
