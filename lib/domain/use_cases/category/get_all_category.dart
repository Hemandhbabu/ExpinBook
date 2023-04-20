import '../../models/category.dart';
import '../../repositories/category_repository.dart';

class GetAllCategory {
  final CategoryRepository _repository;

  const GetAllCategory(this._repository);

  Future<List<Category>> findAll() => _repository.findAll();

  Stream<List<Category>> watchAll() => _repository.watchAll();
}
