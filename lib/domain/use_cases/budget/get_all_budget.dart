import '../../models/budget.dart';
import '../../repositories/budget_repository.dart';

class GetAllBudget {
  final BudgetRepository _repository;

  const GetAllBudget(this._repository);

  Future<List<Budget>> findAll() => _repository.findAll();

  Stream<List<Budget>> watchAll() => _repository.watchAll();
}
