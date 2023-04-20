import '../../models/expin_data.dart';
import '../../repositories/expin_data_repository.dart';

class GetAllExpinData {
  final ExpinDataRepository _repository;

  const GetAllExpinData(this._repository);

  Future<List<ExpinData>> findAll() => _repository.findAllExpinDatas();

  Stream<List<ExpinData>> watchAll() => _repository.watchAllExpinDatas();
}
