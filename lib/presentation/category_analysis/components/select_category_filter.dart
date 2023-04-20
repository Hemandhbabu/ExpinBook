import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/filter_item.dart';
import '../../utils/category_filter.dart';
import '../../utils/category_picker_utils.dart';
import '../category_analysis_provider.dart';

class SelectCategoryFilter extends ConsumerWidget {
  const SelectCategoryFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(CategoryAnalysisProvider.categoryFilterProvider);
    return FilterItem(
      dense: true,
      text: CategoryFilter.category(category).format,
      onTap: () => showCategoryPicker(context, category).then(
        (value) {
          if (value != null) {
            ref
                .read(CategoryAnalysisProvider.categoryFilterProvider.notifier)
                .state = value;
          }
        },
      ),
    );
  }
}
