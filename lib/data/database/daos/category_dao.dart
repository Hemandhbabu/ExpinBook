import 'package:floor/floor.dart';

import '../../../domain/models/category.dart';

@dao
abstract class CategoryDao {
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<int> insertCategory(Category category);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<List<int>> insertAllCategories(List<Category> categories);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateCategory(Category category);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateAllCategories(List<Category> categories);

  @delete
  Future<int> deleteCategory(Category category);

  @delete
  Future<int> deleteAllCategories(List<Category> categories);

  @Query('SELECT * FROM Category WHERE id =:id')
  Future<Category?> findCategoryWithId(int id);

  @Query('SELECT * FROM Category WHERE id =:id')
  Stream<Category?> watchCategoryWithId(int id);

  @Query('SELECT * FROM Category ORDER BY isIncome DESC')
  Future<List<Category>> findAllCategories();

  @Query('SELECT * FROM Category ORDER BY isIncome DESC')
  Stream<List<Category>> watchAllCategories();
}
