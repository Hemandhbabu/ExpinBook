import 'dart:io';

import 'package:excel/excel.dart';
import 'my_iterable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../domain/models/expin_data.dart';
import '../presentation/utils/dialog_utils.dart';
import 'native_utils.dart';
import 'snack_bar_data.dart';
import 'snack_bar_utils.dart';

class ExcelExportUtils {
  const ExcelExportUtils._();
  static void saveExcel({
    required BuildContext context,
    required List<ExpinData> expinDatas,
    bool first = true,
  }) async {
    if (expinDatas.isEmpty) {
      showSnackBar(
        const SnackBarData(message: 'You have no transactions to export'),
      );
      return;
    }
    final version = await NativeUtils.getAndroidVersion() ?? 19;
    var granted = await (version > 29
            ? Permission.manageExternalStorage
            : Permission.storage)
        .isGranted;
    if (!granted) {
      granted = (await (version > 29
                  ? Permission.manageExternalStorage
                  : Permission.storage)
              .request())
          .isGranted;
    }
    if (granted) {
      final isSelected = await showCustomDialog<bool>(
        context: context,
        title: 'Export',
        content: 'Do you want to export the transactions as Excel ?',
        actionsBuilder: (ctx) => [
          CustomDialogAction(
            onTap: () => Navigator.pop(ctx),
            text: 'Cancel',
          ),
          CustomDialogAction(
            text: 'Export',
            onTap: () => Navigator.pop(ctx, true),
          ),
        ],
      );
      if (isSelected != true) {
        return;
      }
      try {
        final output = await FilePicker.platform.getDirectoryPath();
        if (output == null) return;
        final transfers = expinDatas.reduceToField(
          (item) => item.when(expin: (_) => null, transfer: (_) => _),
          (one, two) => one.id == two.id,
        );
        final expins = expinDatas.reduceToField(
          (item) => item.when(expin: (_) => _, transfer: (_) => null),
          (one, two) => one.id == two.id,
        );
        final excel = Excel.createExcel();
        excel.rename(excel.getDefaultSheet()!, 'Expins');
        Sheet sheet = excel['Expins'];
        final cellStyle = CellStyle(
          bold: true,
          horizontalAlign: HorizontalAlign.Center,
        );
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          ..value = 'Date'
          ..cellStyle = cellStyle;
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0))
          ..value = 'Category'
          ..cellStyle = cellStyle;
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0))
          ..value = 'Amount'
          ..cellStyle = cellStyle;
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0))
          ..value = 'Type'
          ..cellStyle = cellStyle;
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0))
          ..value = 'Mode'
          ..cellStyle = cellStyle;
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0))
          ..value = 'Description'
          ..cellStyle = cellStyle;
        for (var i = 1; i < expins.length + 1; i++) {
          final item = expins[i - 1];
          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i))
              .value = DateFormat.yMMMd().format(item.dateTime);
          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i))
              .value = item.categoryName;
          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i))
              .value = item.amount;
          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i))
              .value = item.isIncome ? 'Income' : 'Expense';
          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i))
              .value = item.paymentName;
          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i))
              .value = item.description;
        }
        if (transfers.isNotEmpty) {
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0))
            ..value = 'Date'
            ..cellStyle = cellStyle;
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0))
            ..value = 'Amount'
            ..cellStyle = cellStyle;
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0))
            ..value = 'Type'
            ..cellStyle = cellStyle;
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 0))
            ..value = 'From'
            ..cellStyle = cellStyle;
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 0))
            ..value = 'To'
            ..cellStyle = cellStyle;
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: 0))
            ..value = 'Description'
            ..cellStyle = cellStyle;
          for (var i = 1; i < transfers.length + 1; i++) {
            final item = transfers[i - 1];
            sheet
                .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i))
                .value = DateFormat.yMMMd().format(item.dateTime);
            sheet
                .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i))
                .value = item.amount;
            sheet
                .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i))
                .value = 'Transfer';
            sheet
                .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i))
                .value = item.fromPaymentName;
            sheet
                .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: i))
                .value = item.toPaymentName;
            sheet
                .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: i))
                .value = item.description;
          }
        }
        final fileName = 'ExpinBook-AllData-'
            '${DateFormat('yyMMddHHmmss').format(DateTime.now())}.xlsx';
        final bytes = excel.encode();
        if (bytes != null) {
          final file = File("$output/$fileName");
          await file.writeAsBytes(bytes);
          showSnackBar(
            const SnackBarData(message: 'Excel exported successfully'),
          );
        } else {
          showSnackBar(const SnackBarData(message: 'An error occured'));
        }
      } catch (e) {
        if (kDebugMode) print(e);
      }
    } else {
      showSnackBar(
        SnackBarData(
          message: 'Storage permission required',
          actionLabel: 'Retry',
          action: first
              ? () => saveExcel(
                    context: context,
                    expinDatas: expinDatas,
                    first: false,
                  )
              : null,
        ),
      );
    }
  }
}
