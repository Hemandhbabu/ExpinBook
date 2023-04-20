import 'package:floor/floor.dart';

import '../../../domain/models/loan_transaction.dart';

@dao
abstract class LoanTransactionDao {
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<int> insertLoanTransaction(LoanTransaction loanTransaction);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<List<int>> insertAllLoanTransactions(
      List<LoanTransaction> loanTransactions);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateLoanTransaction(LoanTransaction loanTransaction);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateAllLoanTransactions(List<LoanTransaction> loanTransactions);

  @delete
  Future<int> deleteLoanTransaction(LoanTransaction loanTransaction);

  @delete
  Future<int> deleteAllLoanTransactions(List<LoanTransaction> loanTransactions);

  @Query('SELECT * FROM LoanTransaction WHERE id =:id')
  Future<LoanTransaction?> findLoanTransactionWithId(int id);

  @Query('SELECT * FROM LoanTransaction WHERE id =:id')
  Stream<LoanTransaction?> watchLoanTransactionWithId(int id);

  @Query(
    'SELECT * FROM LoanTransaction WHERE loanId =:loanId ORDER BY dateTime DESC',
  )
  Future<List<LoanTransaction>> findAllLoanTransactionsWithLoanId(int loanId);

  @Query(
    'SELECT * FROM LoanTransaction WHERE loanId =:loanId ORDER BY dateTime DESC',
  )
  Stream<List<LoanTransaction>> watchAllLoanTransactionsWithLoanId(int loanId);

  @Query('SELECT * FROM LoanTransaction ORDER BY dateTime DESC')
  Future<List<LoanTransaction>> findAllLoanTransactions();

  @Query('SELECT * FROM LoanTransaction ORDER BY dateTime DESC')
  Stream<List<LoanTransaction>> watchAllLoanTransactions();
}
