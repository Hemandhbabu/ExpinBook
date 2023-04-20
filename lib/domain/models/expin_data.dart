// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/category_data.dart';
import 'expin.dart';
import 'payment.dart' show PaymentMode;

part 'expin_data.freezed.dart';
part 'expin_data.g.dart';

@freezed
class ExpinData with _$ExpinData {
  const factory ExpinData.expin(IncomeExpense incomeExpense) = _ExpinD;

  const factory ExpinData.transfer(Transfer transfer) = _TransferD;

  const ExpinData._();

  IconData? categoryIcon(int? categoryIconIndex) {
    if (categoryIconIndex == null) return null;
    try {
      return categoryIcons[categoryIconIndex];
    } catch (e) {
      return categoryIcons[0];
    }
  }

  Expin get expin => when(
        expin: (expin) => Expin(
          id: expin.id,
          amount: expin.amount,
          type:
              expin.isIncome ? TransactionType.income : TransactionType.expense,
          categoryId: expin.categoryId,
          paymentId: expin.paymentId,
          toPaymentId: null,
          description: expin.description,
          imagePath: expin.imagePath,
          dateTime: expin.dateTime,
        ),
        transfer: (transfer) => Expin(
          id: transfer.id,
          amount: transfer.amount,
          type: TransactionType.transfer,
          categoryId: -1,
          paymentId: transfer.fromPaymentId,
          toPaymentId: transfer.toPaymentId,
          description: transfer.description,
          imagePath: transfer.imagePath,
          dateTime: transfer.dateTime,
        ),
      );

  // int get id => when(
  //       expin: (incomeExpense) => incomeExpense.id,
  //       transfer: (transfer) => transfer.id,
  //     );
  // double get amount => when(
  //       expin: (incomeExpense) => incomeExpense.amount,
  //       transfer: (transfer) => transfer.amount,
  //     );
  // TransactionType get type => when(
  //       expin: (incomeExpense) => incomeExpense.isIncome
  //           ? TransactionType.income
  //           : TransactionType.expense,
  //       transfer: (transfer) => TransactionType.transfer,
  //     );
  // String? get description => when(
  //       expin: (incomeExpense) => incomeExpense.description,
  //       transfer: (transfer) => transfer.description,
  //     );
  // String? get imagePath => when(
  //       expin: (incomeExpense) => incomeExpense.imagePath,
  //       transfer: (transfer) => transfer.imagePath,
  //     );
  // DateTime get dateTime => when(
  //       expin: (incomeExpense) => incomeExpense.dateTime,
  //       transfer: (transfer) => transfer.dateTime,
  //     );

  factory ExpinData.fromJson(Map<String, dynamic> json) =>
      _$ExpinDataFromJson(json);
}

@freezed
class IncomeExpense with _$IncomeExpense {
  const factory IncomeExpense({
    required int id,
    required double amount,
    required bool isIncome,
    required int categoryId,
    required int paymentId,
    required String? description,
    required String? imagePath,
    required DateTime dateTime,
    required String categoryName,
    required int? categoryIconIndex,
    required String? categorySymbol,
    @ColorConverter() required Color categoryColor,
    required String paymentName,
    required PaymentMode paymentMode,
    @ColorConverter() required Color paymentColor,
  }) = _IncomeExpense;
  const IncomeExpense._();
  IconData? get categoryIcon {
    if (categoryIconIndex == null) return null;
    try {
      return categoryIcons[categoryIconIndex!];
    } catch (e) {
      return categoryIcons[0];
    }
  }

  factory IncomeExpense.fromJson(Map<String, dynamic> json) =>
      _$IncomeExpenseFromJson(json);
}

@freezed
class Transfer with _$Transfer {
  const factory Transfer({
    required int id,
    required double amount,
    required int fromPaymentId,
    required int toPaymentId,
    required String? description,
    required String? imagePath,
    required DateTime dateTime,
    required String fromPaymentName,
    required PaymentMode fromPaymentMode,
    @ColorConverter() required Color fromPaymentColor,
    required String toPaymentName,
    required PaymentMode toPaymentMode,
    @ColorConverter() required Color toPaymentColor,
  }) = _Transfer;
  factory Transfer.fromJson(Map<String, dynamic> json) =>
      _$TransferFromJson(json);
}

class ColorConverter extends JsonConverter<Color, int> {
  const ColorConverter();
  @override
  Color fromJson(int json) {
    return Color(json);
  }

  @override
  int toJson(Color object) {
    return object.value;
  }
}
