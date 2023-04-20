import '../models/payment.dart';

mixin PaymentRepository {
  Future<int> insert(Payment payment);
  Future<List<int>> insertAll(List<Payment> payments);

  Future<bool> update(Payment payment);
  Future<bool> updateAll(List<Payment> payments);

  Future<bool> delete(Payment payment);
  Future<bool> deleteAll(List<Payment> payments);

  Future<Payment?> findWithId(int id);

  Stream<Payment?> watchWithId(int id);

  Future<List<Payment>> findAll();

  Stream<List<Payment>> watchAll();
}
