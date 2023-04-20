// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

import '../../utils/my_icons.dart';

enum PaymentMode {
  cash('Cash', Icons.money_rounded),
  card('Card', Icons.credit_card_rounded),
  cheque('Cheque', MyIcons.cheque_rounded),
  netBanking('Net banking', Icons.account_balance_rounded),
  wallet('Wallet', Icons.account_balance_wallet_rounded),
  upi('UPI', MyIcons.upi);

  final String name;
  final IconData icon;

  const PaymentMode(this.name, this.icon);
}

@entity
class Payment {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final PaymentMode mode;
  final String? description;
  final Color color;
  const Payment({
    required this.id,
    required this.name,
    required this.mode,
    required this.description,
    required this.color,
  });

  Payment copyWith({
    int? id,
    String? name,
    PaymentMode? mode,
    String? description,
    Color? color,
  }) {
    return Payment(
      id: id ?? this.id,
      name: name ?? this.name,
      mode: mode ?? this.mode,
      description: description ?? this.description,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'mode': mode.index,
      'description': description,
      'color': color.value,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      id: map['id'] as int?,
      name: map['name'] as String,
      mode: PaymentMode.values[map['mode'] as int],
      description:
          map['description'] != null ? map['description'] as String : null,
      color: Color(map['color'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) =>
      Payment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Payment(id: $id, name: $name, mode: $mode, description: $description, color: $color)';
  }

  @override
  bool operator ==(covariant Payment other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.mode == mode &&
        other.description == description &&
        other.color == color;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        mode.hashCode ^
        description.hashCode ^
        color.hashCode;
  }
}
