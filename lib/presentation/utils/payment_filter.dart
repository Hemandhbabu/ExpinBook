import '../../domain/models/payment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_filter.freezed.dart';
part 'payment_filter.g.dart';

@freezed
class PaymentFilter with _$PaymentFilter {
  const factory PaymentFilter.all() = _All;
  const factory PaymentFilter.payment(Payment payment) = _Payment;
  const factory PaymentFilter.payments(List<Payment> payments) = _Payments;

  factory PaymentFilter.fromJson(Map<String, Object?> json) =>
      _$PaymentFilterFromJson(json);

  const PaymentFilter._();

  bool get isSinglePayment => when(
        all: () => false,
        payment: (payment) => true,
        payments: (payments) => payments.length <= 1,
      );

  String get format => when(
        all: () => 'All payments',
        payment: (payment) => payment.name,
        payments: (payments) => payments.isEmpty
            ? 'Select payment'
            : payments.length == 1
                ? payments[0].name
                : '${payments[0].name} +${payments.length - 1}',
      );
}
