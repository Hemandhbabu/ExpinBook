import '../../domain/models/budget.dart';
import '../../domain/models/category_data.dart';
import '../../domain/models/expin_data.dart';

class HomeData {
  final List<ExpinData> expins;
  final List<CategoryData> pinnedCategories;
  final Budget? budget;

  const HomeData({
    required this.expins,
    required this.pinnedCategories,
    required this.budget,
  });
}
