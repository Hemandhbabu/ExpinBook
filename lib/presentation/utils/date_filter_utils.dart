import '../../provider/use_cases_provider.dart';
import '../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/base_extensions.dart';
import '../../utils/my_datetime.dart';
import '../../utils/my_iterable.dart';
import '../core/filter_item.dart';
import '../my_impl/custom_date_picker.dart';
import 'date_filter.dart';

final _expandedMonthProvider = StateProvider.autoDispose((ref) => false);
final _expandedYearProvider = StateProvider.autoDispose((ref) => false);
final _elevatedProvider = StateProvider.autoDispose((ref) => false);
final _selectedProvider =
    StateProvider.autoDispose((ref) => const DateFilter.all());
final _monthsProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(
    expinUseCasesProvider.select(
      (value) => value.getAllExpin.watchAll().map(
            (value) => value.reduceToField(
              (item) => item.dateTime,
              (one, two) => one.format('yM') == two.format('yM'),
            ),
          ),
    ),
  ),
);

Future<DateFilter?> showDateFilter(
  BuildContext context,
  DateFilter selected,
) =>
    showDialog<DateFilter>(
      context: context,
      builder: (context) => ProviderScope(
        overrides: [
          _selectedProvider.overrideWith((ref) => selected),
        ],
        child: const _DateFilter(),
      ),
    );

class _DateFilter extends ConsumerWidget {
  const _DateFilter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpandedMonth = ref.watch(_expandedMonthProvider);
    final isExpandedYear = ref.watch(_expandedYearProvider);
    final selected = ref.watch(_selectedProvider);
    return Scaffold(
      appBar: CustomAppBar.elevated(
        provider: _elevatedProvider,
        title: 'Date filter',
        leading: const CustomCloseButton(),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context, selected),
            icon: const Icon(Icons.done_rounded),
          ),
        ],
      ),
      body: AsyncWidgetWrapper(
        asyncValue: ref.watch(_monthsProvider),
        loadingBuilder: (context) => const LoadingChips(),
        builder: (context, months) {
          final now = DateTime.now();
          if (months.isEmpty ||
              !months.map((e) => e.format('yM')).contains(now.format('yM'))) {
            months.add(now);
          }
          final years = months.reduceToField(
            (item) => item,
            (one, two) => one.year == two.year,
          );
          return ScrollNotificationWrapper(
            provider: _elevatedProvider,
            child: ListView(
              children: [
                const TitleCard(title: 'Select all time'),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FilterItem(
                    text: 'Select all time',
                    showDropdown: false,
                    selected: selected.maybeWhen(
                        orElse: () => false, all: () => true),
                    onTap: () => ref.read(_selectedProvider.notifier).state =
                        const DateFilter.all(),
                  ),
                ),
                const SizedBox(height: 4),
                TitleCard(
                  title: 'Select a month',
                  trailing: months.length > 3
                      ? TextButton(
                          onPressed: () => ref
                              .read(_expandedMonthProvider.notifier)
                              .state = !isExpandedMonth,
                          child: Text(
                            isExpandedMonth ? 'Show less' : 'Show all',
                          ),
                        )
                      : null,
                ),
                () {
                  final selectedMonth = selected.maybeWhen(
                    orElse: () => null,
                    month: (dateTime) => dateTime,
                  );
                  final notExpandedItem = selectedMonth ?? DateTime.now();
                  final isExpanded = months.length > 3 ? isExpandedMonth : true;
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Wrap(
                      children: [
                        if (!isExpanded)
                          FilterItem(
                            text: notExpandedItem.dateOrMonthFormat(true),
                            showDropdown: false,
                            selected: selectedMonth?.format('yM') ==
                                notExpandedItem.format('yM'),
                            margin: const EdgeInsets.all(4),
                            onTap: () => ref
                                .read(_selectedProvider.notifier)
                                .state = DateFilter.month(notExpandedItem),
                          ),
                        if (!isExpanded)
                          FilterItem(
                            key: const ValueKey('...'),
                            text: '...',
                            showDropdown: false,
                            margin: const EdgeInsets.all(4),
                            onTap: () => ref
                                .read(_expandedMonthProvider.notifier)
                                .state = true,
                          ),
                        if (isExpanded)
                          ...months.map(
                            (e) => FilterItem(
                              text: e.dateOrMonthFormat(true),
                              showDropdown: false,
                              margin: const EdgeInsets.all(4),
                              selected:
                                  selectedMonth?.format('yM') == e.format('yM'),
                              onTap: () => ref
                                  .read(_selectedProvider.notifier)
                                  .state = DateFilter.month(e),
                            ),
                          ),
                      ],
                    ),
                  );
                }(),
                const SizedBox(height: 4),
                TitleCard(
                  title: 'Select a year',
                  trailing: years.length > 3
                      ? TextButton(
                          onPressed: () => ref
                              .read(_expandedYearProvider.notifier)
                              .state = !isExpandedYear,
                          child: Text(
                            isExpandedYear ? 'Show less' : 'Show all',
                          ),
                        )
                      : null,
                ),
                () {
                  final selectedYear = selected.maybeWhen(
                    orElse: () => null,
                    year: (dateTime) => dateTime,
                  );
                  final notExpandedItem = selectedYear ?? DateTime.now();
                  final isExpanded = years.length > 3 ? isExpandedYear : true;
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Wrap(
                      children: [
                        if (!isExpanded)
                          FilterItem(
                            text: notExpandedItem.year.toString(),
                            showDropdown: false,
                            margin: const EdgeInsets.all(4),
                            selected:
                                selectedYear?.year == notExpandedItem.year,
                            onTap: () => ref
                                .read(_selectedProvider.notifier)
                                .state = DateFilter.year(notExpandedItem),
                          ),
                        if (!isExpanded)
                          FilterItem(
                            key: const ValueKey('...'),
                            text: '...',
                            showDropdown: false,
                            margin: const EdgeInsets.all(4),
                            onTap: () => ref
                                .read(_expandedYearProvider.notifier)
                                .state = true,
                          ),
                        if (isExpanded)
                          ...years.map(
                            (e) => FilterItem(
                              text: e.year.toString(),
                              showDropdown: false,
                              margin: const EdgeInsets.all(4),
                              selected: selectedYear?.year == e.year,
                              onTap: () => ref
                                  .read(_selectedProvider.notifier)
                                  .state = DateFilter.year(e),
                            ),
                          ),
                      ],
                    ),
                  );
                }(),
                const SizedBox(height: 4),
                const TitleCard(title: 'Select a date'),
                () {
                  final selectedDate = selected.maybeWhen(
                    orElse: () => null,
                    date: (dateTime) => dateTime,
                  );
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: FilterItem(
                      text: selectedDate != null
                          ? selectedDate.dateOrMonthFormat(false,
                              alsoWeek: true)
                          : 'Select a date',
                      selected: selectedDate != null,
                      showDropdown: selectedDate == null,
                      onTap: () => showCustomDatePicker(
                        context: context,
                        initialDate: selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      ).then(
                        (value) => value?.let(
                          (value) => ref
                              .read(_selectedProvider.notifier)
                              .update((_) => DateFilter.date(value)),
                        ),
                      ),
                    ),
                  );
                }(),
                const SizedBox(height: 4),
                const TitleCard(title: 'Select a range'),
                () {
                  final selectedRange = selected.maybeWhen(
                    orElse: () => null,
                    dateTimeRange: (range) => range,
                  );
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: FilterItem(
                      text: selectedRange != null
                          ? selectedRange.format
                          : 'Select a range',
                      selected: selectedRange != null,
                      showDropdown: selectedRange == null,
                      onTap: () => showCustomDateRangePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        initialDateRange: selectedRange,
                      ).then(
                        (value) => value?.let(
                          (value) =>
                              ref.read(_selectedProvider.notifier).update(
                                    (_) => DateFilter.dateTimeRange(value),
                                  ),
                        ),
                      ),
                    ),
                  );
                }(),
              ],
            ),
          );
        },
      ),
    );
  }
}
