import 'package:floor/floor.dart';

import '../../../domain/models/expin.dart';

@dao
abstract class ExpinDao {
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<int> insertExpin(Expin expin);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<List<int>> insertAllExpins(List<Expin> expins);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateExpin(Expin expin);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateAllExpins(List<Expin> expins);

  @delete
  Future<int> deleteExpin(Expin expin);

  @delete
  Future<int> deleteAllExpins(List<Expin> expins);

  @Query('SELECT * FROM Expin WHERE id =:id')
  Future<Expin?> findExpinWithId(int id);

  @Query('SELECT * FROM Expin WHERE id =:id')
  Stream<Expin?> watchExpinWithId(int id);

  @Query('SELECT * FROM Expin ORDER BY dateTime DESC')
  Future<List<Expin>> findAllExpins();

  @Query('SELECT * FROM Expin ORDER BY dateTime DESC')
  Stream<List<Expin>> watchAllExpins();
}
