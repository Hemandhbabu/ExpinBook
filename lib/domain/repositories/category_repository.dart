import '../models/category.dart';

mixin CategoryRepository {
  Future<int> insert(Category category);
  Future<List<int>> insertAll(List<Category> categories);

  Future<bool> update(Category category);
  Future<bool> updateAll(List<Category> categories);

  Future<bool> delete(Category category);
  Future<bool> deleteAll(List<Category> categories);

  Future<Category?> findWithId(int id);

  Stream<Category?> watchWithId(int id);

  Future<List<Category>> findAll();

  Stream<List<Category>> watchAll();
}
