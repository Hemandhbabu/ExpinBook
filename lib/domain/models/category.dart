// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:flutter/widgets.dart';

import '../../utils/category_data.dart';

@entity
class Category {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final bool isIncome;
  final int? iconIndex;
  final String? symbol;
  final Color color;
  final String? description;
  const Category({
    required this.id,
    required this.name,
    required this.isIncome,
    required this.iconIndex,
    required this.symbol,
    required this.color,
    required this.description,
  });

  IconData? get icon {
    if (iconIndex == null) return null;
    try {
      return categoryIcons[iconIndex!];
    } catch (e) {
      return categoryIcons[0];
    }
  }

  Category copyWith({
    int? id,
    String? name,
    bool? isIncome,
    int? iconIndex,
    String? symbol,
    Color? color,
    String? description,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      isIncome: isIncome ?? this.isIncome,
      iconIndex: iconIndex ?? this.iconIndex,
      symbol: symbol ?? this.symbol,
      color: color ?? this.color,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'isIncome': isIncome,
      'iconIndex': iconIndex,
      'symbol': symbol,
      'color': color.value,
      'description': description,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int?,
      name: map['name'] as String,
      isIncome: map['isIncome'] as bool,
      iconIndex: map['iconIndex'] != null ? map['iconIndex'] as int : null,
      symbol: map['symbol'] != null ? map['symbol'] as String : null,
      color: Color(map['color'] as int),
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(id: $id, name: $name, isIncome: $isIncome, iconIndex: $iconIndex, symbol: $symbol, color: $color, description: $description)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.isIncome == isIncome &&
        other.iconIndex == iconIndex &&
        other.symbol == symbol &&
        other.color == color &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        isIncome.hashCode ^
        iconIndex.hashCode ^
        symbol.hashCode ^
        color.hashCode ^
        description.hashCode;
  }
}
