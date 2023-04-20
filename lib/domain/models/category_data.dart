// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../presentation/utils/date_filter.dart';
import 'category.dart';

class CategoryData {
  final Category category;
  final double amount;
  final int noOfTransactions;
  final DateFilter filter;
  const CategoryData({
    required this.category,
    required this.amount,
    required this.noOfTransactions,
    required this.filter,
  });

  CategoryData copyWith({
    Category? category,
    double? amount,
    int? noOfTransactions,
    DateFilter? filter,
  }) {
    return CategoryData(
      category: category ?? this.category,
      amount: amount ?? this.amount,
      noOfTransactions: noOfTransactions ?? this.noOfTransactions,
      filter: filter ?? this.filter,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category.toMap(),
      'amount': amount,
      'noOfTransactions': noOfTransactions,
      'filter': filter.toJson(),
    };
  }

  factory CategoryData.fromMap(Map<String, dynamic> map) {
    return CategoryData(
      category: Category.fromMap(map['category'] as Map<String, dynamic>),
      amount: map['amount'] as double,
      noOfTransactions: map['noOfTransactions'] as int,
      filter: DateFilter.fromJson(map['filter'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryData.fromJson(String source) =>
      CategoryData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoryData(category: $category, amount: $amount, noOfTransactions: $noOfTransactions, filter: $filter)';
  }

  @override
  bool operator ==(covariant CategoryData other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.amount == amount &&
        other.noOfTransactions == noOfTransactions &&
        other.filter == filter;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        amount.hashCode ^
        noOfTransactions.hashCode ^
        filter.hashCode;
  }
}
