import '../../../domain/models/category.dart';
import '../../utils/date_filter.dart';

class CategoryAnalysisArg {
  final DateFilter dateFilter;
  final Category category;

  const CategoryAnalysisArg({required this.dateFilter, required this.category});
}
