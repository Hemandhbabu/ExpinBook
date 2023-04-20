// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

@entity
class Budget {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final double amount;
  final List<int> budgetForCategories;
  const Budget({
    required this.id,
    required this.name,
    required this.amount,
    required this.budgetForCategories,
  });

  Budget removeCategory(int id) {
    final budgetForCategories = this.budgetForCategories;
    budgetForCategories.removeWhere((e) => e == id);
    return Budget(
      id: this.id,
      name: name,
      amount: amount,
      budgetForCategories: budgetForCategories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'amount': amount,
      'budgetForCategories': jsonEncode(budgetForCategories),
    };
  }

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'] as int?,
      name: map['name'] as String,
      amount: map['amount'] as double,
      budgetForCategories:
          (jsonDecode(map['budgetForCategories']) as List).cast<int>(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Budget.fromJson(String source) =>
      Budget.fromMap(json.decode(source) as Map<String, dynamic>);

  Budget copyWith({
    int? id,
    String? name,
    double? amount,
    List<int>? budgetForCategories,
  }) {
    return Budget(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      budgetForCategories: budgetForCategories ?? this.budgetForCategories,
    );
  }

  @override
  String toString() {
    return 'Budget(id: $id, name: $name, amount: $amount, budgetForCategories: $budgetForCategories)';
  }

  @override
  bool operator ==(covariant Budget other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.amount == amount &&
        listEquals(other.budgetForCategories, budgetForCategories);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        amount.hashCode ^
        budgetForCategories.hashCode;
  }
}
