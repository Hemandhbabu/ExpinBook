import '../../models/payment.dart';
import '../../repositories/expin_repository.dart';
import '../../repositories/payment_repository.dart';

class ModifyPayment {
  final PaymentRepository _repository;
  final ExpinRepository _expinRepository;

  const ModifyPayment(this._repository, this._expinRepository);

  Future<bool> add(Payment payment) {
    return _repository.insert(payment).then((value) => value > 0);
  }

  Future<List<int>> addAll(List<Payment> payments) {
    return _repository.insertAll(payments);
  }

  Future<bool> update(Payment payment) {
    return _repository.update(payment);
  }

  Future<bool> delete(Payment payment) async {
    try {
      final expins = (await _expinRepository.findAll())
          .where((element) => element.paymentId == payment.id)
          .map((e) => e.copyWith(paymentId: 1))
          .toList();
      await _expinRepository.updateAll(expins);
      return _repository.delete(payment);
    } catch (e) {
      return Future.value(false);
    }
  }
}
