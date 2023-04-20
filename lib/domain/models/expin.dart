// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

enum TransactionType {
  income(Icons.arrow_downward_rounded, 'Income', Colors.green),
  expense(Icons.arrow_upward_rounded, 'Expense', Colors.red),
  transfer(Icons.swap_horiz_rounded, 'Transfer', Colors.blue);

  final IconData icon;
  final String name;
  final Color color;
  const TransactionType(this.icon, this.name, this.color);
}

@entity
class Expin {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final double amount;
  final TransactionType type;
  final int categoryId;
  final int paymentId;
  final int? toPaymentId;
  final String? description;
  final String? imagePath;
  final DateTime dateTime;
  const Expin({
    required this.id,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.paymentId,
    required this.toPaymentId,
    required this.description,
    required this.imagePath,
    required this.dateTime,
  });

  bool get isIncome => type == TransactionType.income;
  bool get isExpense => type == TransactionType.expense;
  bool get isTransfer => type == TransactionType.transfer;

  Expin copyWith({
    int? id,
    double? amount,
    TransactionType? type,
    int? categoryId,
    int? paymentId,
    int? toPaymentId,
    String? description,
    String? imagePath,
    DateTime? dateTime,
  }) {
    return Expin(
      id: id == -1 ? null : (id ?? this.id),
      amount: amount ?? this.amount,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      paymentId: paymentId ?? this.paymentId,
      toPaymentId: toPaymentId ?? this.toPaymentId,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'type': type.index,
      'categoryId': categoryId,
      'paymentId': paymentId,
      'toPaymentId': toPaymentId,
      'description': description,
      'imagePath': imagePath,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory Expin.fromMap(Map<String, dynamic> map) {
    return Expin(
      id: map['id'] != null ? map['id'] as int : null,
      amount: map['amount'] as double,
      type: map['type'] != null
          ? TransactionType.values[map['type'] as int]
          : (map['isIncome'] as bool)
              ? TransactionType.income
              : TransactionType.expense,
      categoryId: map['categoryId'] as int,
      paymentId: map['paymentId'] as int,
      toPaymentId:
          map['toPaymentId'] != null ? map['toPaymentId'] as int : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      imagePath: map['imagePath'] != null ? map['imagePath'] as String : null,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Expin.fromJson(String source) =>
      Expin.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expin(id: $id, amount: $amount, type: $type, categoryId: $categoryId, paymentId: $paymentId, toPaymentId: $toPaymentId, description: $description, imagePath: $imagePath, dateTime: $dateTime)';
  }

  @override
  bool operator ==(covariant Expin other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.amount == amount &&
        other.type == type &&
        other.categoryId == categoryId &&
        other.paymentId == paymentId &&
        other.toPaymentId == toPaymentId &&
        other.description == description &&
        other.imagePath == imagePath &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        type.hashCode ^
        categoryId.hashCode ^
        paymentId.hashCode ^
        toPaymentId.hashCode ^
        description.hashCode ^
        imagePath.hashCode ^
        dateTime.hashCode;
  }
}
