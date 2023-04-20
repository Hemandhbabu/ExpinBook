import '../../domain/models/category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_filter.freezed.dart';
part 'category_filter.g.dart';

@freezed
class CategoryFilter with _$CategoryFilter {
  const factory CategoryFilter.all() = _All;
  const factory CategoryFilter.income() = _Income;
  const factory CategoryFilter.expense() = _Expense;
  const factory CategoryFilter.transfer() = _Transfer;
  const factory CategoryFilter.category(Category category) = _Category;
  const factory CategoryFilter.categories(List<Category> categories) =
      _Categories;

  factory CategoryFilter.fromJson(Map<String, Object?> json) =>
      _$CategoryFilterFromJson(json);

  const CategoryFilter._();

  bool get hasAll => maybeWhen(
        orElse: () => false,
        all: () => true,
        categories: (categories) {
          if (categories.length <= 1) return false;
          final list = categories.map((e) => e.isIncome);
          return list.contains(true) && list.contains(false);
        },
      );
  bool get hasIncome => maybeWhen(
        orElse: () => false,
        all: () => true,
        income: () => true,
        categories: (categories) => categories.length > 1
            ? categories.map((e) => e.isIncome).contains(true)
            : false,
      );
  bool get hasExpense => maybeWhen(
        orElse: () => false,
        all: () => true,
        expense: () => true,
        categories: (categories) => categories.length > 1
            ? categories.map((e) => e.isIncome).contains(false)
            : false,
      );
  bool get isSingleCategory => maybeWhen(
        orElse: () => false,
        category: (category) => true,
        categories: (categories) => categories.length <= 1,
      );
  bool get isTransfer => maybeWhen(orElse: () => false, transfer: () => true);

  String get format => when(
        all: () => 'All categories',
        income: () => 'Income categories',
        expense: () => 'Expense categories',
        transfer: () => 'Transfers',
        category: (category) =>
            '${category.isIncome ? 'Income' : 'Expense'} : ${category.name}',
        categories: (categories) => categories.isEmpty
            ? 'Select category'
            : categories.length == 1
                ? categories[0].name
                : '${categories[0].name} +${categories.length - 1}',
      );
}
