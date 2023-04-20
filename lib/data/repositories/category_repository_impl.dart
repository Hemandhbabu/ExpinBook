import '../../domain/models/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../database/daos/category_dao.dart';

class CategoryRepositoryImpl with CategoryRepository {
  final CategoryDao _dao;

  const CategoryRepositoryImpl(this._dao);

  @override
  Future<int> insert(Category category) {
    return _dao.insertCategory(category);
  }

  @override
  Future<List<int>> insertAll(List<Category> categories) async {
    return _dao.insertAllCategories(categories);
  }

  @override
  Future<bool> update(Category category) {
    return _dao.updateCategory(category).then((value) => value > 0);
  }

  @override
  Future<bool> updateAll(List<Category> categories) async {
    return _dao.updateAllCategories(categories).then((value) => value > 0);
  }

  @override
  Future<bool> delete(Category category) {
    return _dao.deleteCategory(category).then((value) => value > 0);
  }

  @override
  Future<bool> deleteAll(List<Category> categories) async {
    return _dao.deleteAllCategories(categories).then((value) => value > 0);
  }

  @override
  Future<Category?> findWithId(int id) => _dao.findCategoryWithId(id);

  @override
  Stream<Category?> watchWithId(int id) => _dao.watchCategoryWithId(id);

  @override
  Future<List<Category>> findAll() => _dao.findAllCategories();

  @override
  Stream<List<Category>> watchAll() => _dao.watchAllCategories();
}
