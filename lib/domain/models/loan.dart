// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

import '../../utils/category_data.dart';

@entity
class Loan {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final double interest;
  final int? iconIndex;
  final String? symbol;
  final Color color;
  final String? description;
  final DateTime dateTime;

  const Loan({
    required this.id,
    required this.name,
    required this.interest,
    required this.iconIndex,
    required this.symbol,
    required this.color,
    required this.description,
    required this.dateTime,
  });

  IconData? get icon {
    if (iconIndex == null) return null;
    try {
      return categoryIcons[iconIndex!];
    } catch (e) {
      return categoryIcons[0];
    }
  }

  Loan copyWith({
    int? id,
    String? name,
    double? amount,
    double? interest,
    int? iconIndex,
    String? symbol,
    Color? color,
    String? description,
    DateTime? dateTime,
  }) {
    return Loan(
      id: id ?? this.id,
      name: name ?? this.name,
      interest: interest ?? this.interest,
      iconIndex: iconIndex ?? this.iconIndex,
      symbol: symbol ?? this.symbol,
      color: color ?? this.color,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'interest': interest,
      'iconIndex': iconIndex,
      'symbol': symbol,
      'color': color.value,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory Loan.fromMap(Map<String, dynamic> map) {
    return Loan(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      interest: map['interest'] as double? ?? 0,
      iconIndex: map['iconIndex'] != null ? map['iconIndex'] as int : null,
      symbol: map['symbol'] != null ? map['symbol'] as String : null,
      color: Color(map['color'] as int),
      description:
          map['description'] != null ? map['description'] as String : null,
      dateTime: DateTime.fromMillisecondsSinceEpoch(
        map['dateTime'] as int? ?? DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Loan.fromJson(String source) =>
      Loan.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Loan(id: $id, name: $name, interest: $interest, iconIndex: $iconIndex, symbol: $symbol, color: $color, description: $description, dateTime: $dateTime)';
  }

  @override
  bool operator ==(covariant Loan other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.interest == interest &&
        other.iconIndex == iconIndex &&
        other.symbol == symbol &&
        other.color == color &&
        other.description == description &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        interest.hashCode ^
        iconIndex.hashCode ^
        symbol.hashCode ^
        color.hashCode ^
        description.hashCode ^
        dateTime.hashCode;
  }
}
