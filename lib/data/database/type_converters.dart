import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart' show Color;

import '../../domain/models/expin.dart';
import '../../domain/models/payment.dart';

class DateTimeConverter extends TypeConverter<DateTime, String> {
  @override
  DateTime decode(String databaseValue) {
    return DateTime.parse(databaseValue);
  }

  @override
  String encode(DateTime value) {
    return value.toIso8601String();
  }
}

class ColorConverter extends TypeConverter<Color, int> {
  @override
  Color decode(int databaseValue) {
    return Color(databaseValue);
  }

  @override
  int encode(Color value) {
    return value.value;
  }
}

class PaymentModeConverter extends TypeConverter<PaymentMode, int> {
  @override
  PaymentMode decode(int databaseValue) {
    return PaymentMode.values[databaseValue];
  }

  @override
  int encode(PaymentMode value) {
    return value.index;
  }
}

class IntListConverter extends TypeConverter<List<int>, String> {
  @override
  List<int> decode(String databaseValue) {
    return (jsonDecode(databaseValue) as List).cast<int>();
  }

  @override
  String encode(List<int> value) {
    return jsonEncode(value);
  }
}

class TransactionTypeConverter extends TypeConverter<TransactionType, int> {
  @override
  TransactionType decode(int databaseValue) {
    return TransactionType.values[databaseValue];
  }

  @override
  int encode(TransactionType value) {
    return value.index;
  }
}
