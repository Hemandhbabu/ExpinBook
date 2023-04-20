import '../../repositories/loan_transaction_repository.dart';

import '../../models/loan.dart';
import '../../repositories/loan_repository.dart';

class ModifyLoan {
  final LoanRepository _repository;
  final LoanTransactionRepository _transactionRepository;

  const ModifyLoan(this._repository, this._transactionRepository);

  Future<bool> add(Loan loan) async {
    return _repository.insert(loan).then((value) => value > 0);
  }

  Future<List<int>> addAll(List<Loan> loans) {
    return _repository.insertAll(loans);
  }

  Future<bool> update(Loan loan) {
    return _repository.update(loan);
  }

  Future<bool> delete(Loan loan) async {
    try {
      final transactions =
          await _transactionRepository.findAllWithLoanId(loan.id!);
      await _transactionRepository.deleteAll(transactions);
      return _repository.delete(loan);
    } catch (e) {
      return Future.value(false);
    }
  }
}
