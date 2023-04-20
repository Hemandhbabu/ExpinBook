import 'dart:convert';

import '../../utils/my_datetime.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_filter.freezed.dart';
part 'date_filter.g.dart';

@freezed
class DateFilter with _$DateFilter {
  const factory DateFilter.all() = _All;
  const factory DateFilter.date(DateTime dateTime) = _Date;
  const factory DateFilter.month(DateTime dateTime) = _Month;
  const factory DateFilter.year(DateTime dateTime) = _Year;
  const factory DateFilter.dateTimeRange(
    @DateTimeRangeJsonConverter() DateTimeRange range,
  ) = _DateTimeRange;

  factory DateFilter.fromJson(Map<String, Object?> json) =>
      _$DateFilterFromJson(json);

  const DateFilter._();

  String get format => when(
        all: () => 'All time',
        date: (date) => date.dateOrMonthFormat(false, alsoWeek: true),
        month: (month) => month.dateOrMonthFormat(true),
        year: (year) => '${year.year}',
        dateTimeRange: (range) => range.format,
      );
}

class DateTimeRangeJsonConverter extends JsonConverter<DateTimeRange, String> {
  const DateTimeRangeJsonConverter();
  @override
  DateTimeRange fromJson(String json) {
    final data = (jsonDecode(json) as List).cast<String>();
    return DateTimeRange(
      start: DateTime.parse(data[0]),
      end: DateTime.parse(data[1]),
    );
  }

  @override
  String toJson(DateTimeRange object) {
    return jsonEncode(
      [
        object.start.toIso8601String(),
        object.end.toIso8601String(),
      ],
    );
  }
}
