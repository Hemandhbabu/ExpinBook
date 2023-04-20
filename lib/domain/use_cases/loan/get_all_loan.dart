import '../../models/loan.dart';
import '../../repositories/loan_repository.dart';

class GetAllLoan {
  final LoanRepository _repository;

  const GetAllLoan(this._repository);

  Future<List<Loan>> findAll() => _repository.findAll();

  Stream<List<Loan>> watchAll() => _repository.watchAll();
}
