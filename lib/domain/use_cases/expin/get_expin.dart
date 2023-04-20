import '../../models/expin.dart';
import '../../repositories/expin_repository.dart';

class GetExpin {
  final ExpinRepository _repository;

  const GetExpin(this._repository);

  Future<Expin?> findWithId(int id) => _repository.findWithId(id);

  Stream<Expin?> watchWithId(int id) => _repository.watchWithId(id);
}
