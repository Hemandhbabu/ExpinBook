import 'package:floor/floor.dart';

import '../../../domain/models/budget.dart';

@dao
abstract class BudgetDao {
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<int> insertBudget(Budget budget);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<List<int>> insertAllBudgets(List<Budget> budgets);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateBudget(Budget budget);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateAllBudgets(List<Budget> budgets);

  @delete
  Future<int> deleteBudget(Budget budget);

  @delete
  Future<int> deleteAllBudgets(List<Budget> budgets);

  @Query('SELECT * FROM Budget LIMIT 1')
  Future<Budget?> findFirstBudget();

  @Query('SELECT * FROM Budget LIMIT 1')
  Stream<Budget?> watchFirstBudget();

  @Query('SELECT * FROM Budget WHERE id =:id')
  Future<Budget?> findBudgetWithId(int id);

  @Query('SELECT * FROM Budget WHERE id =:id')
  Stream<Budget?> watchBudgetWithId(int id);

  @Query('SELECT * FROM Budget')
  Future<List<Budget>> findAllBudgets();

  @Query('SELECT * FROM Budget')
  Stream<List<Budget>> watchAllBudgets();
}

extension on Budget {}
