import '../../domain/models/payment.dart';
import '../../domain/repositories/payment_repository.dart';
import '../database/daos/payment_dao.dart';

class PaymentRepositoryImpl with PaymentRepository {
  final PaymentDao _dao;

  const PaymentRepositoryImpl(this._dao);

  @override
  Future<int> insert(Payment payment) {
    return _dao.insertPayment(payment);
  }

  @override
  Future<List<int>> insertAll(List<Payment> payments) async {
    return _dao.insertAllPayments(payments);
  }

  @override
  Future<bool> update(Payment payment) {
    return _dao.updatePayment(payment).then((value) => value > 0);
  }

  @override
  Future<bool> updateAll(List<Payment> payments) async {
    return _dao.updateAllPayments(payments).then((value) => value > 0);
  }

  @override
  Future<bool> delete(Payment payment) {
    return _dao.deletePayment(payment).then((value) => value > 0);
  }

  @override
  Future<bool> deleteAll(List<Payment> payments) async {
    return _dao.deleteAllPayments(payments).then((value) => value > 0);
  }

  @override
  Future<Payment?> findWithId(int id) => _dao.findPaymentWithId(id);

  @override
  Stream<Payment?> watchWithId(int id) => _dao.watchPaymentWithId(id);

  @override
  Future<List<Payment>> findAll() => _dao.findAllPayments();

  @override
  Stream<List<Payment>> watchAll() => _dao.watchAllPayments();
}
