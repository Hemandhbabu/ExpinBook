import '../../models/expin_data.dart';
import '../../repositories/expin_data_repository.dart';

class GetExpinData {
  final ExpinDataRepository _repository;

  const GetExpinData(this._repository);

  Future<ExpinData?> findWithId(int id) => _repository.findWithId(id);

  Stream<ExpinData?> watchWithId(int id) => _repository.watchWithId(id);
}
