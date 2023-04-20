import '../../models/payment.dart';
import '../../repositories/payment_repository.dart';

class GetPayment {
  final PaymentRepository _repository;

  const GetPayment(this._repository);

  Future<Payment?> findWithId(int id) => _repository.findWithId(id);

  Stream<Payment?> watchWithId(int id) => _repository.watchWithId(id);
}
