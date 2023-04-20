import '../models/loan_transaction.dart';

mixin LoanTransactionRepository {
  Future<int> insert(LoanTransaction loanTransaction);
  Future<List<int>> insertAll(List<LoanTransaction> loanTransactions);

  Future<bool> update(LoanTransaction loanTransaction);
  Future<bool> updateAll(List<LoanTransaction> loanTransactions);

  Future<bool> delete(LoanTransaction loanTransaction);
  Future<bool> deleteAll(List<LoanTransaction> loanTransactions);

  Future<LoanTransaction?> findWithId(int id);

  Stream<LoanTransaction?> watchWithId(int id);

  Future<List<LoanTransaction>> findAllWithLoanId(int loanId);

  Stream<List<LoanTransaction>> watchAllWithLoanId(int loanId);

  Future<List<LoanTransaction>> findAll();
  Stream<List<LoanTransaction>> watchAll();
}
