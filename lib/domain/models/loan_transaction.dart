// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';

@entity
class LoanTransaction {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final double amount;
  final int loanId;
  final String? description;
  final String? imagePath;
  final DateTime dateTime;
  final bool isPay;

  const LoanTransaction({
    required this.id,
    required this.amount,
    required this.loanId,
    required this.description,
    required this.imagePath,
    required this.dateTime,
    required this.isPay,
  });

  LoanTransaction copyWith({
    int? id,
    double? amount,
    int? loanId,
    String? description,
    String? imagePath,
    DateTime? dateTime,
    bool? isPay,
  }) {
    return LoanTransaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      loanId: loanId ?? this.loanId,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      dateTime: dateTime ?? this.dateTime,
      isPay: isPay ?? this.isPay,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'loanId': loanId,
      'description': description,
      'imagePath': imagePath,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'isPay': isPay,
    };
  }

  factory LoanTransaction.fromMap(Map<String, dynamic> map) {
    return LoanTransaction(
      id: map['id'] != null ? map['id'] as int : null,
      amount: map['amount'] as double,
      loanId: map['loanId'] as int,
      description:
          map['description'] != null ? map['description'] as String : null,
      imagePath: map['imagePath'] != null ? map['imagePath'] as String : null,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      isPay: map['isPay'] as bool? ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoanTransaction.fromJson(String source) =>
      LoanTransaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoanTransaction(id: $id, amount: $amount, loanId: $loanId, description: $description, imagePath: $imagePath, dateTime: $dateTime, isPay: $isPay)';
  }

  @override
  bool operator ==(covariant LoanTransaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.amount == amount &&
        other.loanId == loanId &&
        other.description == description &&
        other.imagePath == imagePath &&
        other.dateTime == dateTime &&
        other.isPay == isPay;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        loanId.hashCode ^
        description.hashCode ^
        imagePath.hashCode ^
        dateTime.hashCode ^
        isPay.hashCode;
  }
}
