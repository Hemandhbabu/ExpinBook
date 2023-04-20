import '../models/expin.dart';

mixin ExpinRepository {
  Future<int> insert(Expin expin);
  Future<List<int>> insertAll(List<Expin> expins);

  Future<bool> update(Expin expin);
  Future<bool> updateAll(List<Expin> expins);

  Future<bool> delete(Expin expin);
  Future<bool> deleteAll(List<Expin> expins);

  Future<Expin?> findWithId(int id);

  Stream<Expin?> watchWithId(int id);

  Future<List<Expin>> findAll();

  Stream<List<Expin>> watchAll();
}
