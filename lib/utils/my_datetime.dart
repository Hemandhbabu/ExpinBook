import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../presentation/utils/date_filter.dart';

extension MyDateTime on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
  }) =>
      DateTime(
        year ?? this.year,
        month ?? this.month,
        day ?? this.day,
        hour ?? this.hour,
        minute ?? this.minute,
        second ?? this.second,
      );

  String dateOrMonthFormat(
    bool month, {
    bool alsoWeek = false,
    bool useToday = true,
    bool alwaysShowTime = false,
    bool adaptiveDateAndTime = false,
  }) {
    assert(
      (alwaysShowTime == true || adaptiveDateAndTime == false) ||
          (alwaysShowTime == false || adaptiveDateAndTime == true) ||
          (alwaysShowTime == false || adaptiveDateAndTime == false),
    );
    final now = DateTime.now();
    if (useToday && !month) {
      if (format('yMd') == now.format('yMd')) {
        if (adaptiveDateAndTime) return timeFormat();
        const result = 'Today';
        if (alwaysShowTime) return '$result, ${timeFormat()}';
        return result;
      }
      if (format('yMd') ==
          now.subtract(const Duration(days: 1)).format('yMd')) {
        const result = 'Yesterday';
        if (alwaysShowTime) return '$result, ${timeFormat()}';
        return result;
      }
    }
    return DateFormat(
          '${now.year == year ? '' : 'y'}'
          'MMM${month ? 'M' : alsoWeek ? 'Ed' : 'd'}',
        ).format(this) +
        (alwaysShowTime ? ', ${timeFormat()}' : '');
  }

  DateTime addMonth(int noOfMonth) => DateTime(
        year,
        month + noOfMonth,
        day,
        hour,
        minute,
        second,
      );

  DateTime copyTimeOfDay(TimeOfDay timeOfDay) =>
      DateTime(year, month, day, timeOfDay.hour, timeOfDay.minute, 0);

  int get inTimeSeconds => (hour * 60 * 60) + (minute * 60) + second;
  int get inTimeMilliSeconds =>
      (hour * 60 * 60 * 1000) +
      (minute * 60 * 1000) +
      (second * 1000) +
      millisecond;

  int get inTimeMinutes => (hour * 60) + minute;

  bool isAtSameDayAs(DateTime dateTime) =>
      dateTime.year == year && dateTime.month == month && dateTime.day == day;

  bool isAtSameMonthAs(DateTime dateTime) =>
      dateTime.year == year && dateTime.month == month;

  int timeDifference(DateTime dateTime) =>
      inTimeMinutes - dateTime.inTimeMinutes;

  String timeFormat([String? locale]) => DateFormat.jm(locale).format(this);

  String format(String format, [String? locale]) =>
      DateFormat(format, locale).format(this);

  int get monthMaxDays => _monthMaxDays(month, year);

  int get yearMaxDays => year % 4 == 0 ? 366 : 365;

  int get noOfDaysThisYearTillToday {
    int noOfDays = 0;
    for (var i = 1; i < month; i++) {
      final days = _monthMaxDays(i, year);
      noOfDays += days;
    }
    noOfDays += day;
    return noOfDays;
  }

  bool filter(DateFilter filter) {
    return filter.when(
      all: () => true,
      date: (date) => date.format('yMd') == format('yMd'),
      month: (month) {
        final format = DateFormat.yM().format;
        return format(this) == format(month);
      },
      year: (year) => this.year == year.year,
      dateTimeRange: (range) {
        int format(DateTime date) =>
            int.parse(DateFormat('yyyyMMdd').format(date));
        return format(this) >= format(range.start) &&
            format(this) <= format(range.end);
      },
    );
  }
}

extension MyRange on DateTimeRange {
  String get format {
    final first = start.dateOrMonthFormat(false, useToday: false);
    final last = end.dateOrMonthFormat(false, useToday: false);
    if (first == last) return start.dateOrMonthFormat(false, alsoWeek: true);
    return '$first - $last';
  }
}

int _monthMaxDays(int month, int year) {
  {
    switch (month) {
      case 1:
        return 31;
      case 2:
        return year % 4 == 0 ? 29 : 28;
      case 3:
        return 31;
      case 4:
        return 30;
      case 5:
        return 31;
      case 6:
        return 30;
      case 7:
        return 31;
      case 8:
        return 31;
      case 9:
        return 30;
      case 10:
        return 31;
      case 11:
        return 30;
      case 12:
        return 31;
      default:
        return 0;
    }
  }
}
