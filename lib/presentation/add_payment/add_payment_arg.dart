import '../../domain/models/payment.dart';

class AddPaymentArg {
  final bool editable;
  final Payment? payment;

  const AddPaymentArg({this.editable = false, this.payment});
}
