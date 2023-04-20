import '../../models/loan.dart';
import '../../repositories/loan_repository.dart';

class GetLoan {
  final LoanRepository _repository;

  const GetLoan(this._repository);

  Future<Loan?> findWithId(int id) => _repository.findWithId(id);

  Stream<Loan?> watchWithId(int id) => _repository.watchWithId(id);
}
