import '../../domain/models/budget.dart';
import '../../domain/repositories/budget_repository.dart';
import '../database/daos/budget_dao.dart';

class BudgetRepositoryImpl with BudgetRepository {
  final BudgetDao _dao;

  const BudgetRepositoryImpl(this._dao);

  @override
  Future<int> insert(Budget budget) {
    return _dao.insertBudget(budget);
  }

  @override
  Future<List<int>> insertAll(List<Budget> budgets) {
    return _dao.insertAllBudgets(budgets);
  }

  @override
  Future<bool> update(Budget budget) {
    return _dao.updateBudget(budget).then((value) => value > 0);
  }

  @override
  Future<bool> updateAll(List<Budget> budgets) async {
    return _dao.updateAllBudgets(budgets).then((value) => value > 0);
  }

  @override
  Future<bool> delete(Budget budget) {
    return _dao.deleteBudget(budget).then((value) => value > 0);
  }

  @override
  Future<bool> deleteAll(List<Budget> budgets) async {
    return _dao.deleteAllBudgets(budgets).then((value) => value > 0);
  }

  @override
  Future<Budget?> findWithId(int id) => _dao.findBudgetWithId(id);

  @override
  Stream<Budget?> watchWithId(int id) => _dao.watchBudgetWithId(id);

  @override
  Future<List<Budget>> findAll() => _dao.findAllBudgets();

  @override
  Stream<List<Budget>> watchAll() => _dao.watchAllBudgets();

  @override
  Future<Budget?> findFirst() => _dao.findFirstBudget();

  @override
  Stream<Budget?> watchFirst() => _dao.watchFirstBudget();
}
