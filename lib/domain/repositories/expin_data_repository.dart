import '../models/expin_data.dart';

mixin ExpinDataRepository {
  Future<ExpinData?> findWithId(int id);

  Stream<ExpinData?> watchWithId(int id);

  Future<List<ExpinData>> findAllExpinDatas();

  Stream<List<ExpinData>> watchAllExpinDatas();
}
