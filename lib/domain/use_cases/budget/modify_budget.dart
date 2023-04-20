import '../../models/budget.dart';
import '../../repositories/budget_repository.dart';

class ModifyBudget {
  final BudgetRepository _repository;

  const ModifyBudget(this._repository);

  Future<bool> add(Budget budget) {
    return _repository.insert(budget).then((value) => value > 0);
  }

  Future<List<int>> addAll(List<Budget> budgets) {
    return _repository.insertAll(budgets);
  }

  Future<bool> update(Budget budget) {
    return _repository.update(budget);
  }

  Future<bool> delete(Budget budget) {
    return _repository.delete(budget);
  }
}
