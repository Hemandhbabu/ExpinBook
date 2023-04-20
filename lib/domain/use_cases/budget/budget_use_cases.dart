import 'get_all_budget.dart';
import 'get_budget.dart';
import 'modify_budget.dart';

class BudgetUseCases {
  final ModifyBudget modifyBudget;
  final GetBudget getBudget;
  final GetAllBudget getAllBudget;

  const BudgetUseCases({
    required this.modifyBudget,
    required this.getBudget,
    required this.getAllBudget,
  });
}
