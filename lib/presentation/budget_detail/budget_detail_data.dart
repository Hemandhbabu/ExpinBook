import 'package:flutter/foundation.dart';

import '../../domain/models/budget.dart';
import '../../domain/models/category_data.dart';

class BudgetDetailData {
  final Budget budget;
  final List<CategoryData> categories;

  const BudgetDetailData({
    required this.budget,
    required this.categories,
  });

  BudgetDetailData copyWith({
    Budget? budget,
    List<CategoryData>? categories,
  }) {
    return BudgetDetailData(
      budget: budget ?? this.budget,
      categories: categories ?? this.categories,
    );
  }

  @override
  String toString() =>
      'BudgetDetailData(budget: $budget, categories: $categories)';

  @override
  bool operator ==(covariant BudgetDetailData other) {
    if (identical(this, other)) return true;

    return other.budget == budget && listEquals(other.categories, categories);
  }

  @override
  int get hashCode => budget.hashCode ^ categories.hashCode;
}
