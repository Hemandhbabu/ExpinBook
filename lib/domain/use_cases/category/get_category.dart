import '../../models/category.dart';
import '../../repositories/category_repository.dart';

class GetCategory {
  final CategoryRepository _repository;

  const GetCategory(this._repository);

  Future<Category?> findWithId(int id) => _repository.findWithId(id);

  Stream<Category?> watchWithId(int id) => _repository.watchWithId(id);
}
