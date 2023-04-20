import '../models/budget.dart';

mixin BudgetRepository {
  Future<int> insert(Budget budget);
  Future<List<int>> insertAll(List<Budget> budgets);

  Future<bool> update(Budget budget);
  Future<bool> updateAll(List<Budget> budgets);

  Future<bool> delete(Budget budget);
  Future<bool> deleteAll(List<Budget> budgets);

  Future<Budget?> findWithId(int id);

  Stream<Budget?> watchWithId(int id);

  Future<Budget?> findFirst();

  Stream<Budget?> watchFirst();

  Future<List<Budget>> findAll();

  Stream<List<Budget>> watchAll();
}
