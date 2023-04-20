import 'get_all_category.dart';
import 'get_category.dart';
import 'modify_category.dart';

class CategoryUseCases {
  final ModifyCategory modifyCategory;
  final GetCategory getCategory;
  final GetAllCategory getAllCategory;

  const CategoryUseCases({
    required this.modifyCategory,
    required this.getCategory,
    required this.getAllCategory,
  });
}
