import '../models/loan.dart';

mixin LoanRepository {
  Future<int> insert(Loan loan);
  Future<List<int>> insertAll(List<Loan> loans);

  Future<bool> update(Loan loan);
  Future<bool> updateAll(List<Loan> loans);

  Future<bool> delete(Loan loan);
  Future<bool> deleteAll(List<Loan> loans);

  Future<Loan?> findWithId(int id);

  Stream<Loan?> watchWithId(int id);

  Future<List<Loan>> findAll();

  Stream<List<Loan>> watchAll();
}
