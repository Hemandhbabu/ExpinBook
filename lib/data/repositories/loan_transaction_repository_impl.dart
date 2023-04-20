import '../database/daos/loan_transaction_dao.dart';
import '../../domain/models/loan_transaction.dart';
import '../../domain/repositories/loan_transaction_repository.dart';

class LoanTransactionRepositoryImpl implements LoanTransactionRepository {
  final LoanTransactionDao _dao;

  const LoanTransactionRepositoryImpl(this._dao);
  @override
  Future<bool> delete(LoanTransaction loanTransaction) =>
      _dao.deleteLoanTransaction(loanTransaction).then((value) => value > 0);

  @override
  Future<bool> deleteAll(List<LoanTransaction> loanTransactions) => _dao
      .deleteAllLoanTransactions(loanTransactions)
      .then((value) => value > 0);

  @override
  Future<LoanTransaction?> findWithId(int id) =>
      _dao.findLoanTransactionWithId(id);

  @override
  Future<int> insert(LoanTransaction loanTransaction) =>
      _dao.insertLoanTransaction(loanTransaction);

  @override
  Future<List<int>> insertAll(List<LoanTransaction> loanTransactions) =>
      _dao.insertAllLoanTransactions(loanTransactions);

  @override
  Future<bool> update(LoanTransaction loanTransaction) =>
      _dao.updateLoanTransaction(loanTransaction).then((value) => value > 0);

  @override
  Future<bool> updateAll(List<LoanTransaction> loanTransactions) => _dao
      .updateAllLoanTransactions(loanTransactions)
      .then((value) => value > 0);

  @override
  Stream<LoanTransaction?> watchWithId(int id) =>
      _dao.watchLoanTransactionWithId(id);

  @override
  Future<List<LoanTransaction>> findAllWithLoanId(int loanId) =>
      _dao.findAllLoanTransactionsWithLoanId(loanId);

  @override
  Stream<List<LoanTransaction>> watchAllWithLoanId(int loanId) =>
      _dao.watchAllLoanTransactionsWithLoanId(loanId);

  @override
  Future<List<LoanTransaction>> findAll() => _dao.findAllLoanTransactions();

  @override
  Stream<List<LoanTransaction>> watchAll() => _dao.watchAllLoanTransactions();
}
