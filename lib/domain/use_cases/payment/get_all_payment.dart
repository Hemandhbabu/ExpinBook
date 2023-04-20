import '../../models/payment.dart';
import '../../repositories/payment_repository.dart';

class GetAllPayment {
  final PaymentRepository _repository;

  const GetAllPayment(this._repository);

  Future<List<Payment>> findAll() => _repository.findAll();

  Stream<List<Payment>> watchAll() => _repository.watchAll();
}
