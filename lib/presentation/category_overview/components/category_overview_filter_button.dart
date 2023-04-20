import '../../utils/category_filter.dart';
import '../../utils/date_filter.dart';
import '../../../utils/type_def_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/category_filter_utils.dart';
import '../../utils/date_filter_utils.dart';
import '../../utils/show_action_utils.dart';
import '../category_overview_provider.dart';

class CategoryOverviewFilterButton extends ConsumerWidget {
  const CategoryOverviewFilterButton({super.key});

  static void selectCategory({
    required BuildContext context,
    required CategoryFilter category,
    required Reader read,
  }) =>
      showCategoryFilter(context, category, false).then(
        (value) {
          if (value != null) {
            read(CategoryOverviewProvider.categoryFilterProvider.notifier)
                .state = value;
          }
        },
      );

  static void showFilter({
    required BuildContext context,
    required DateFilter date,
    required CategoryFilter category,
    required Reader read,
  }) =>
      showCustomAction(
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
              text: category.format,
              value: 1,
            ),
          ],
          valueChanged: (value) {
            if (value == 0) {
              showDateFilter(context, date).then(
                (value) {
                  if (value != null) {
                    read(CategoryOverviewProvider.dateFilterProvider.notifier)
                        .state = value;
                  }
                },
              );
            } else if (value == 1) {
              selectCategory(context: context, category: category, read: read);
            }
          },
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(CategoryOverviewProvider.dateFilterProvider);
    final category = ref.watch(CategoryOverviewProvider.categoryFilterProvider);
    return IconButton(
      onPressed: () => showFilter(
        context: context,
        date: date,
        category: category,
        read: ref.read,
      ),
      icon: const Icon(Icons.filter_alt_rounded),
    );
  }
}
