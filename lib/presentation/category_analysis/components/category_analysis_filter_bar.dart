import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/filter_item.dart';
import '../../utils/date_filter_utils.dart';
import '../category_analysis_provider.dart';
import 'select_category_filter.dart';

class CategoryAnalysisFilterBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const CategoryAnalysisFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(CategoryAnalysisProvider.dateFilterProvider);
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
                          CategoryAnalysisProvider.dateFilterProvider.notifier)
                      .state = value;
                }
              },
            ),
          ),
          const SelectCategoryFilter(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(46);
}
