import 'package:floor/floor.dart';

import '../../../domain/models/loan.dart';

@dao
abstract class LoanDao {
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<int> insertLoan(Loan loan);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<List<int>> insertAllLoans(List<Loan> loans);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateLoan(Loan loan);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateAllLoans(List<Loan> loans);

  @delete
  Future<int> deleteLoan(Loan loan);

  @delete
  Future<int> deleteAllLoans(List<Loan> loans);

  @Query('SELECT * FROM Loan WHERE id =:id')
  Future<Loan?> findLoanWithId(int id);

  @Query('SELECT * FROM Loan WHERE id =:id')
  Stream<Loan?> watchLoanWithId(int id);

  @Query('SELECT * FROM Loan')
  Future<List<Loan>> findAllLoans();

  @Query('SELECT * FROM Loan')
  Stream<List<Loan>> watchAllLoans();
}
