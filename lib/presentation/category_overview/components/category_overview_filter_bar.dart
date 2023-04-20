import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/filter_item.dart';
import '../../utils/category_filter_utils.dart';
import '../../utils/date_filter_utils.dart';
import '../category_overview_provider.dart';

class CategoryOverviewFilterBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const CategoryOverviewFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(CategoryOverviewProvider.dateFilterProvider);
    final category = ref.watch(CategoryOverviewProvider.categoryFilterProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterItem(
            dense: true,
            text: date.format,
            onTap: () => showDateFilter(context, date).then(
              (value) {
                if (value != null) {
                  ref
                      .read(
                          CategoryOverviewProvider.dateFilterProvider.notifier)
                      .state = value;
                }
              },
            ),
          ),
          FilterItem(
            dense: true,
            text: category.format,
            onTap: () =>
                showCategoryFilter(context, category, false).then((value) {
              if (value != null) {
                ref
                    .read(CategoryOverviewProvider
                        .categoryFilterProvider.notifier)
                    .state = value;
              }
            }),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(46);
}
