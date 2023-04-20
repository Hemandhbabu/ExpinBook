import '../../models/expin.dart';
import '../../repositories/expin_repository.dart';

class GetAllExpin {
  final ExpinRepository _repository;

  const GetAllExpin(this._repository);

  Future<List<Expin>> findAll() => _repository.findAll();

  Stream<List<Expin>> watchAll() => _repository.watchAll();
}
