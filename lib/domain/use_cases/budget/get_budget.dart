import '../../models/budget.dart';
import '../../repositories/budget_repository.dart';

class GetBudget {
  final BudgetRepository _repository;

  const GetBudget(this._repository);

  Future<Budget?> findWithId(int id) => _repository.findWithId(id);

  Stream<Budget?> watchWithId(int id) => _repository.watchWithId(id);

  Future<Budget?> findFirst() => _repository.findFirst();

  Stream<Budget?> watchFirst() => _repository.watchFirst();
}
