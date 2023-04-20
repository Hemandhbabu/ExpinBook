import '../../models/category.dart';
import '../../repositories/budget_repository.dart';
import '../../repositories/category_repository.dart';
import '../../repositories/expin_repository.dart';

class ModifyCategory {
  final CategoryRepository _repository;
  final ExpinRepository _expinRepository;
  final BudgetRepository _budgetRepository;

  const ModifyCategory(
    this._repository,
    this._expinRepository,
    this._budgetRepository,
  );

  Future<bool> add(Category category) {
    return _repository.insert(category).then((value) => value > 0);
  }

  Future<List<int>> addAll(List<Category> categories) {
    return _repository.insertAll(categories);
  }

  Future<bool> update(Category category) {
    return _repository.update(category);
  }

  Future<bool> delete(Category category) async {
    try {
      final expins = (await _expinRepository.findAll())
          .where((element) => element.categoryId == category.id)
          .map((e) => e.copyWith(categoryId: e.isIncome ? 1 : 6))
          .toList();
      await _expinRepository.updateAll(expins);
      final budgets = (await _budgetRepository.findAll())
          .where((element) => element.budgetForCategories.contains(category.id))
          .map((e) => e.removeCategory(category.id!))
          .toList();
      await _budgetRepository.updateAll(budgets);
      return _repository.delete(category);
    } catch (e) {
      return Future.value(false);
    }
  }
}
