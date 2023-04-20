import '../../domain/models/category.dart';

class AddCategoryArg {
  final bool editable;
  final Category? category;

  const AddCategoryArg({
    this.editable = false,
    this.category,
  });
}
