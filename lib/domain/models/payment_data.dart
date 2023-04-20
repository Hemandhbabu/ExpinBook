// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../presentation/utils/date_filter.dart';
import 'payment.dart';

class PaymentData {
  final Payment payment;
  final double amount;
  final int noOfTransactions;
  final DateFilter filter;
  final bool isIncome;
  const PaymentData({
    required this.payment,
    required this.amount,
    required this.noOfTransactions,
    required this.filter,
    required this.isIncome,
  });

  PaymentData copyWith({
    Payment? payment,
    double? amount,
    int? noOfTransactions,
    DateFilter? filter,
    bool? isIncome,
  }) {
    return PaymentData(
      payment: payment ?? this.payment,
      amount: amount ?? this.amount,
      noOfTransactions: noOfTransactions ?? this.noOfTransactions,
      filter: filter ?? this.filter,
      isIncome: isIncome ?? this.isIncome,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'payment': payment.toMap(),
      'amount': amount,
      'noOfTransactions': noOfTransactions,
      'filter': filter.toJson(),
      'isIncome': isIncome,
    };
  }

  factory PaymentData.fromMap(Map<String, dynamic> map) {
    return PaymentData(
      payment: Payment.fromMap(map['payment'] as Map<String, dynamic>),
      amount: map['amount'] as double,
      noOfTransactions: map['noOfTransactions'] as int,
      filter: DateFilter.fromJson(map['filter'] as Map<String, dynamic>),
      isIncome: map['isIncome'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentData.fromJson(String source) =>
      PaymentData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentData(payment: $payment, amount: $amount, noOfTransactions: $noOfTransactions, filter: $filter, isIncome: $isIncome)';
  }

  @override
  bool operator ==(covariant PaymentData other) {
    if (identical(this, other)) return true;

    return other.payment == payment &&
        other.amount == amount &&
        other.noOfTransactions == noOfTransactions &&
        other.filter == filter &&
        other.isIncome == isIncome;
  }

  @override
  int get hashCode {
    return payment.hashCode ^
        amount.hashCode ^
        noOfTransactions.hashCode ^
        filter.hashCode ^
        isIncome.hashCode;
  }
}
