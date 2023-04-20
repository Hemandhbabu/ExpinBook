import 'package:floor/floor.dart';

import '../../../domain/models/payment.dart';

@dao
abstract class PaymentDao {
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<int> insertPayment(Payment payment);

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<List<int>> insertAllPayments(List<Payment> payments);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updatePayment(Payment payment);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<int> updateAllPayments(List<Payment> payments);

  @delete
  Future<int> deletePayment(Payment payment);

  @delete
  Future<int> deleteAllPayments(List<Payment> payments);

  @Query('SELECT * FROM Payment WHERE id =:id')
  Future<Payment?> findPaymentWithId(int id);

  @Query('SELECT * FROM Payment WHERE id =:id')
  Stream<Payment?> watchPaymentWithId(int id);

  @Query('SELECT * FROM Payment')
  Future<List<Payment>> findAllPayments();

  @Query('SELECT * FROM Payment')
  Stream<List<Payment>> watchAllPayments();
}
