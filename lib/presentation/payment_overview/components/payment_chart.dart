import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/payment_data.dart';
import '../../../utils/my_iterable.dart';
import '../../core_package/core_widget.dart';

final _sectionDatasProvider = FutureProvider.autoDispose.family(
  (ref, String json) => compute(_showingSections, json),
);

List<PieChartSectionData> _showingSections(String json) {
  final fromJson = (jsonDecode(json) as List).cast<String>();
  final size = double.parse(fromJson[0]);
  final data = (jsonDecode(fromJson[1]) as List).cast<String>().map(
        (e) => PaymentData.fromJson(e),
      );
  final total = data.map((e) => e.amount).addition;
  if (total <= 0) return [];
  return data.map((item) {
    final value = item.amount;
    final percent = (value / total) * 100;
    return PieChartSectionData(
      color: item.payment.color,
      title: '${percent.toStringAsFixed(1)} %',
      value: value,
      radius: size * 0.32,
      showTitle: percent > 7.5,
      titlePositionPercentageOffset: 0.5,
      titleStyle: TextStyle(
        fontSize: 16,
        color: ThemeData.estimateBrightnessForColor(item.payment.color) ==
                Brightness.light
            ? Colors.black
            : Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }).toList();
}

class PaymentChart extends StatelessWidget {
  final bool isIncome;
  final List<PaymentData> data;
  PaymentChart({
    super.key,
    required this.isIncome,
    required List<PaymentData> data,
  }) : data = data
            .where((e) => (e.isIncome == isIncome) && (e.amount > 0))
            .toList();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: AspectRatio(
          aspectRatio: 1.1,
          child: data.isEmpty
              ? const CenterText('No transactions')
              : LayoutBuilder(
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
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
