import '../../domain/models/expin.dart';
import '../../domain/repositories/expin_repository.dart';
import '../database/daos/expin_dao.dart';

class ExpinRepositoryImpl with ExpinRepository {
  final ExpinDao _dao;

  const ExpinRepositoryImpl(this._dao);

  @override
  Future<int> insert(Expin expin) {
    return _dao.insertExpin(expin);
  }

  @override
  Future<List<int>> insertAll(List<Expin> expins) async {
    return _dao.insertAllExpins(expins);
  }

  @override
  Future<bool> update(Expin expin) {
    return _dao.updateExpin(expin).then((value) => value > 0);
  }

  @override
  Future<bool> updateAll(List<Expin> expins) async {
    return _dao.updateAllExpins(expins).then((value) => value > 0);
  }

  @override
  Future<bool> delete(Expin expin) {
    return _dao.deleteExpin(expin).then((value) => value > 0);
  }

  @override
  Future<bool> deleteAll(List<Expin> expins) async {
    return _dao.deleteAllExpins(expins).then((value) => value > 0);
  }

  @override
  Future<Expin?> findWithId(int id) => _dao.findExpinWithId(id);

  @override
  Future<List<Expin>> findAll() => _dao.findAllExpins();

  @override
  Stream<Expin?> watchWithId(int id) => _dao.watchExpinWithId(id);

  @override
  Stream<List<Expin>> watchAll() => _dao.watchAllExpins();
}
