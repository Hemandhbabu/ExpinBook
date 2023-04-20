import '../../domain/models/loan.dart';
import '../../domain/repositories/loan_repository.dart';
import '../database/daos/loan_dao.dart';

class LoanRepositoryImpl implements LoanRepository {
  final LoanDao _dao;

  const LoanRepositoryImpl(this._dao);
  @override
  Future<bool> delete(Loan loan) =>
      _dao.deleteLoan(loan).then((value) => value > 0);

  @override
  Future<bool> deleteAll(List<Loan> loans) =>
      _dao.deleteAllLoans(loans).then((value) => value > 0);

  @override
  Future<List<Loan>> findAll() => _dao.findAllLoans();

  @override
  Future<Loan?> findWithId(int id) => _dao.findLoanWithId(id);

  @override
  Future<int> insert(Loan loan) => _dao.insertLoan(loan);

  @override
  Future<List<int>> insertAll(List<Loan> loans) => _dao.insertAllLoans(loans);

  @override
  Future<bool> update(Loan loan) =>
      _dao.updateLoan(loan).then((value) => value > 0);

  @override
  Future<bool> updateAll(List<Loan> loans) =>
      _dao.updateAllLoans(loans).then((value) => value > 0);

  @override
  Stream<List<Loan>> watchAll() => _dao.watchAllLoans();

  @override
  Stream<Loan?> watchWithId(int id) => _dao.watchLoanWithId(id);
}
