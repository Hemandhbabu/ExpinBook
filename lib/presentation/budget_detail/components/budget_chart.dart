import 'dart:convert';

import '../../core_package/add_edit_info_card.dart';
import '../../core_package/async_widget_wrapper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/category.dart';
import '../../../domain/models/category_data.dart';
import '../../../utils/base_extensions.dart';
import '../../../utils/my_iterable.dart';
import '../../utils/date_filter.dart';
import '../budget_detail_data.dart';

final _sectionDatasProvider = FutureProvider.autoDispose.family(
  (ref, String json) => compute(_showingSections, json),
);

List<PieChartSectionData> _showingSections(
  String json,
) {
  final fromJson = (jsonDecode(json) as List).cast<String>();
  final size = double.parse(fromJson[0]);
  final data = (jsonDecode(fromJson[1]) as List)
      .cast<String>()
      .map((e) => CategoryData.fromJson(e));
  final total = data.map((e) => e.amount).addition;
  if (total <= 0) return [];
  return data.map((item) {
    final value = item.amount;
    final percent = (value / total) * 100;
    final hasSymbol = item.category.let(
      (category) => category.iconIndex != null || category.symbol != null,
    );
    return PieChartSectionData(
      color: item.category.color.withOpacity(hasSymbol ? 1 : 0.1),
      title: !hasSymbol ? '' : '${percent.toStringAsFixed(1)} %',
      value: value,
      radius: size,
      showTitle: percent > 7.5,
      titlePositionPercentageOffset: 0.5,
      titleStyle: TextStyle(
        fontSize: 16,
        color: ThemeData.estimateBrightnessForColor(item.category.color) ==
                Brightness.light
            ? Colors.black
            : Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }).toList();
}

class BudgetChart extends StatelessWidget {
  final BudgetDetailData budgetDetailData;
  const BudgetChart({
    super.key,
    required this.budgetDetailData,
  });

  List<PieChartSectionData> budgetSections(
    double budget,
    double expense,
    double size,
  ) {
    final budgetChart = <PieChartSectionData>[];
    budgetChart.add(
      PieChartSectionData(
        color: Colors.green,
        value: budget,
        radius: size,
        showTitle: false,
      ),
    );
    if (expense > budget) {
      var excess = expense - budget;
      budgetChart.add(
        PieChartSectionData(
          color: Colors.red,
          showTitle: false,
          value: excess,
          radius: size,
        ),
      );
    }
    return budgetChart;
  }

  @override
  Widget build(BuildContext context) {
    final data = [...budgetDetailData.categories]
      ..removeWhere((element) => element.amount <= 0);
    final budget = budgetDetailData.budget.amount;
    final expense = data.map((e) => e.amount).addition;
    if (budget > expense) {
      final value = CategoryData(
        category: const Category(
          id: -1,
          name: '',
          isIncome: false,
          iconIndex: null,
          symbol: null,
          color: Colors.transparent,
          description: null,
        ),
        amount: budget - expense,
        noOfTransactions: 0,
        filter: DateFilter.month(DateTime.now()),
      );
      data.add(value);
    }
    return AddEditInfoCard(
      title: 'Expense chart',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AspectRatio(
          aspectRatio: 1.1,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.biggest.shortestSide;
              return Stack(
                children: [
                  Positioned.fill(
                    child: Consumer(
                      builder: (context, ref, child) => AsyncWidgetWrapper(
                        asyncValue: ref.watch(
                          _sectionDatasProvider(
                            jsonEncode([
                              '${size * 0.235}',
                              jsonEncode(
                                data.map((e) => e.toJson()).toList(),
                              ),
                            ]),
                          ),
                        ),
                        builder: (context, data) => PieChart(
                          PieChartData(
                            startDegreeOffset: -90,
                            sections: data,
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: size * 0.24,
                    bottom: size * 0.24,
                    left: size * 0.24,
                    right: size * 0.24,
                    child: PieChart(
                      PieChartData(
                        startDegreeOffset: -90,
                        sections: budgetSections(
                          budget,
                          expense,
                          size * 0.15,
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 1,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
