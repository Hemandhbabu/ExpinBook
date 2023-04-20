import 'dart:convert';

import '../../core_package/async_widget_wrapper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/category_data.dart';
import '../../../utils/my_iterable.dart';

final _sectionDatasProvider = FutureProvider.autoDispose.family(
  (ref, String json) => compute(_showingSections, json),
);

List<PieChartSectionData> _showingSections(String json) {
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
    return PieChartSectionData(
      color: item.category.color,
      title: '${percent.toStringAsFixed(1)} %',
      value: value,
      radius: size * 0.32,
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

class CategoryChart extends StatelessWidget {
  final bool isIncome;
  final List<CategoryData> data;
  CategoryChart({
    super.key,
    required this.isIncome,
    required List<CategoryData> data,
  }) : data = data
            .where((e) => (e.category.isIncome == isIncome) && e.amount > 0)
            .toList();

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox.shrink();
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: AspectRatio(
          aspectRatio: 1.1,
          child: LayoutBuilder(
            builder: (context, constraints) => Consumer(
                builder: (context, ref, _) => AsyncWidgetWrapper(
                      asyncValue: ref.watch(
                        _sectionDatasProvider(
                          jsonEncode([
                            '${constraints.biggest.shortestSide}',
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
                    )),
          ),
        ),
      ),
    );
  }
}
