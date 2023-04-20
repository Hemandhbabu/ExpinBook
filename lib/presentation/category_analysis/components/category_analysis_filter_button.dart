import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/category_filter.dart';
import '../../utils/category_picker_utils.dart';
import '../../utils/date_filter_utils.dart';
import '../../utils/show_action_utils.dart';
import '../category_analysis_provider.dart';

class CategoryAnalysisFilterButton extends ConsumerWidget {
  const CategoryAnalysisFilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(CategoryAnalysisProvider.dateFilterProvider);
    final category = ref.watch(CategoryAnalysisProvider.categoryFilterProvider);
    return IconButton(
      onPressed: () => showCustomAction(
        context,
        TileActionData(
          actions: [
            TileAction(
              icon: Icons.today_rounded,
              text: date.format,
              value: 0,
            ),
            TileAction(
              icon: Icons.category_rounded,
              text: CategoryFilter.category(category).format,
              value: 1,
            ),
          ],
          valueChanged: (value) {
            if (value == 0) {
              showDateFilter(context, date).then(
                (value) {
                  if (value != null) {
                    ref
                        .read(CategoryAnalysisProvider
                            .dateFilterProvider.notifier)
                        .update((state) => value);
                  }
                },
              );
            } else if (value == 1) {
              showCategoryPicker(context, category).then(
                (value) {
                  if (value != null) {
                    ref
                        .read(CategoryAnalysisProvider
                            .categoryFilterProvider.notifier)
                        .update((state) => value);
                  }
                },
              );
            }
          },
        ),
      ),
      icon: const Icon(Icons.filter_alt_rounded),
    );
  }
}
