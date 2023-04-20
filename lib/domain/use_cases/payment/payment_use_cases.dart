import 'get_all_payment.dart';
import 'get_payment.dart';
import 'modify_payment.dart';

class PaymentUseCases {
  final ModifyPayment modifyPayment;
  final GetPayment getPayment;
  final GetAllPayment getAllPayment;

  const PaymentUseCases({
    required this.modifyPayment,
    required this.getPayment,
    required this.getAllPayment,
  });
}
