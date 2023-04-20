import 'dart:typed_data';

import 'package:flutter/material.dart' as mtl;
import 'package:flutter/services.dart' show rootBundle;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../domain/models/expin.dart';
import '../domain/models/expin_data.dart';
import '../presentation/core/currency_text.dart';
import '../presentation/core_package/custom_app_bar.dart';
import '../presentation/transaction_overview/components/transaction_filter_button.dart';
import '../presentation/transaction_overview/transaction_overview_provider.dart';
import '../presentation/utils/category_filter.dart';
import '../presentation/utils/date_filter.dart';
import '../presentation/utils/payment_filter.dart';
import '../provider/preferences_provider.dart';
import 'my_iterable.dart';
import 'snack_bar_data.dart';
import 'snack_bar_utils.dart';

// const double _cm = 72.0 / 2.54;
// const _format = PdfPageFormat(21.0 * _cm, 29.7 * _cm, marginAll: _cm * 1.5);
const _format = PdfPageFormat.a4;

class PdfExportUtils {
  const PdfExportUtils._();
  static void savePdf(mtl.BuildContext context) async {
    mtl.Navigator.push(
      context,
      mtl.MaterialPageRoute(
        builder: (context) => const _PdfPreviewPage(),
      ),
    );
  }

  static Widget _buildHeader(String date, Font bold, Font normal, Font icon) =>
      Header(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              const IconData(0xe800),
              font: icon,
              size: 32,
              color: const PdfColor(0, 0, 0, 0.85),
            ),
            Text(
              'Expin Book',
              style: TextStyle(font: bold, fontSize: 26, color: PdfColors.blue),
            ),
            Text(
              'Report\n$date',
              textAlign: TextAlign.center,
              style: TextStyle(font: normal),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
      );

  static mtl.DateTimeRange dataFullRange(List<Expin> data) {
    DateTime first = DateTime.now();
    if (data.isEmpty) return mtl.DateTimeRange(start: first, end: first);

    for (var item in data) {
      if (item.dateTime.isBefore(first)) {
        first = item.dateTime;
      }
    }
    DateTime last = DateTime(0);
    for (var item in data) {
      if (item.dateTime.isAfter(last)) {
        last = item.dateTime;
      }
    }
    return mtl.DateTimeRange(start: first, end: last);
  }

  static Future<Document> _buildPages({
    required String currency,
    required DateFilter range,
    required CategoryFilter category,
    required PaymentFilter payment,
    required List<ExpinData> expinDatas,
  }) async {
    final pdf = Document();
    final normal =
        Font.ttf(await rootBundle.load('fonts/Montserrat-Regular.ttf'));
    final semibold =
        Font.ttf(await rootBundle.load('fonts/Montserrat-SemiBold.ttf'));
    final bold = Font.ttf(await rootBundle.load('fonts/Montserrat-Bold.ttf'));
    final icon = Font.ttf(await rootBundle.load('fonts/MyIcons.ttf'));
    expinDatas = expinDatas.reversed.toList();
    final transfers = expinDatas.reduceToField(
      (item) => item.when(expin: (_) => null, transfer: (_) => _),
      (one, two) => one.id == two.id,
    );
    final expins = expinDatas.reduceToField(
      (item) => item.when(expin: (_) => _, transfer: (_) => null),
      (one, two) => one.id == two.id,
    );
    final income =
        expins.where((e) => e.isIncome).map((e) => e.amount).addition;
    final expense =
        expins.where((e) => !e.isIncome).map((e) => e.amount).addition;
    final format = CurrencyText.format(currency);
    final date = range
        .maybeWhen(
          all: () => DateFilter.dateTimeRange(
            dataFullRange(expinDatas.map((e) => e.expin).toList()),
          ),
          orElse: () => range,
        )
        .format;
    if (expins.isEmpty) {
      pdf.addPage(
        Page(
          pageFormat: _format,
          // const PdfPageFormat(21.0 * _cm, 11.0 * _cm, marginAll: _cm * 1.5),
          build: (ctx) => Column(
            children: [
              _buildHeader(date, bold, normal, icon),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category.format,
                    style: TextStyle(font: semibold),
                  ),
                  Text(
                    payment.format,
                    style: TextStyle(font: semibold),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'No data',
                    style: TextStyle(font: semibold, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      return pdf;
    }
    pdf.addPage(
      MultiPage(
        pageFormat: _format,
        header: (context) => _buildHeader(date, bold, normal, icon),
        footer: (context) => Align(
          alignment: Alignment.centerRight,
          child: Text('Page ${context.pageNumber} of ${context.pagesCount}'),
        ),
        build: (ctx) => [
          SizedBox(height: PdfPageFormat.cm * 0.25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category.format, style: TextStyle(font: semibold)),
              Text(
                payment.format,
                style: TextStyle(font: semibold),
              ),
            ],
          ),
          SizedBox(height: PdfPageFormat.cm),
          Align(
            child: Text(
              'Summary',
              style: TextStyle(font: semibold, fontSize: 18),
            ),
          ),
          SizedBox(height: PdfPageFormat.cm * 0.5),
          Row(children: [
            Expanded(
              flex: 12,
              child: Table.fromTextArray(
                cellAlignment: Alignment.center,
                headerAlignment: Alignment.center,
                headerStyle: TextStyle(font: semibold),
                cellStyle: TextStyle(font: normal),
                cellHeight: 30,
                headerDecoration: const BoxDecoration(color: PdfColors.blue50),
                rowDecoration: const BoxDecoration(color: PdfColors.grey50),
                headers: ['No. of transactions'],
                data: [
                  ['${expins.length}']
                ],
                border: null,
              ),
            ),
            Expanded(
              flex: 10,
              child: Table.fromTextArray(
                cellAlignment: Alignment.center,
                headerAlignment: Alignment.center,
                headerStyle: TextStyle(font: semibold),
                cellStyle: TextStyle(font: normal),
                cellHeight: 30,
                headerDecoration: const BoxDecoration(color: PdfColors.green50),
                rowDecoration: const BoxDecoration(color: PdfColors.grey50),
                headers: ['Income'],
                data: [
                  [format.format(income)]
                ],
                border: null,
              ),
            ),
            Expanded(
              flex: 10,
              child: Table.fromTextArray(
                cellAlignment: Alignment.center,
                headerAlignment: Alignment.center,
                headerStyle: TextStyle(font: semibold),
                cellStyle: TextStyle(font: normal),
                cellHeight: 30,
                headerDecoration: const BoxDecoration(color: PdfColors.red50),
                rowDecoration: const BoxDecoration(color: PdfColors.grey50),
                headers: ['Expense'],
                data: [
                  [format.format(expense)]
                ],
                border: null,
              ),
            ),
            if (category.hasAll)
              Expanded(
                flex: 10,
                child: Table.fromTextArray(
                  cellAlignment: Alignment.center,
                  headerAlignment: Alignment.center,
                  headerStyle: TextStyle(font: semibold),
                  cellStyle: TextStyle(font: normal),
                  cellHeight: 30,
                  headerDecoration:
                      const BoxDecoration(color: PdfColors.blue50),
                  rowDecoration: const BoxDecoration(color: PdfColors.grey50),
                  headers: ['Savings'],
                  data: [
                    [format.format(income - expense)]
                  ],
                  border: null,
                ),
              ),
          ]),
          SizedBox(height: PdfPageFormat.cm),
          Align(
            child: Text(
              'Transactions',
              style: TextStyle(font: semibold, fontSize: 18),
            ),
          ),
          SizedBox(height: PdfPageFormat.cm * 0.5),
          Table.fromTextArray(
            headerAlignment: Alignment.center,
            headers: [
              'Date',
              'Category',
              'Amount',
              'Mode',
              'Details',
            ],
            headerStyle: TextStyle(font: semibold),
            headerDecoration: const BoxDecoration(color: PdfColors.blue50),
            cellStyle: TextStyle(font: normal),
            cellHeight: 30,
            border: null,
            oddRowDecoration: const BoxDecoration(color: PdfColors.grey50),
            columnWidths: {
              0: const FractionColumnWidth(0.2),
              1: const FractionColumnWidth(0.2),
              2: const FractionColumnWidth(0.2),
              3: const FractionColumnWidth(0.2),
              4: const FractionColumnWidth(0.2),
            },
            cellAlignment: Alignment.center,
            data: expins
                .map(
                  (e) => [
                    DateFormat('dd-MM-yyyy').format(e.dateTime),
                    e.categoryName,
                    (e.isIncome ? '' : '-') + format.format(e.amount),
                    e.paymentName,
                    e.description?.isNotEmpty == true ? e.description! : '-',
                  ],
                )
                .toList(),
          ),
          SizedBox(height: PdfPageFormat.cm),
          Align(
            child: Text(
              'Transfers',
              style: TextStyle(font: semibold, fontSize: 18),
            ),
          ),
          SizedBox(height: PdfPageFormat.cm * 0.5),
          Table.fromTextArray(
            headerAlignment: Alignment.center,
            headers: [
              'Date',
              'Amount',
              'From',
              'To',
              'Details',
            ],
            headerStyle: TextStyle(font: semibold),
            headerDecoration: const BoxDecoration(color: PdfColors.blue50),
            cellStyle: TextStyle(font: normal),
            cellHeight: 30,
            border: null,
            oddRowDecoration: const BoxDecoration(color: PdfColors.grey50),
            columnWidths: {
              0: const FractionColumnWidth(0.2),
              1: const FractionColumnWidth(0.2),
              2: const FractionColumnWidth(0.2),
              3: const FractionColumnWidth(0.2),
              4: const FractionColumnWidth(0.2),
            },
            cellAlignment: Alignment.center,
            data: transfers
                .map(
                  (e) => [
                    DateFormat('dd-MM-yyyy').format(e.dateTime),
                    format.format(e.amount),
                    e.fromPaymentName,
                    e.toPaymentName,
                    e.description?.isNotEmpty == true ? e.description! : '-',
                  ],
                )
                .toList(),
          ),
        ],
      ),
    );
    if (!category.isSingleCategory) {
      final categoryData = _categoryWithExpinsConvert(expins);
      final incomeCategories = categoryData.where((e) => e.isIncome).toList();
      final expenseCategories = categoryData.where((e) => !e.isIncome).toList();
      pdf.addPage(
        MultiPage(
          header: (context) => _buildHeader(date, bold, normal, icon),
          footer: (context) => Align(
            alignment: Alignment.centerRight,
            child: Text('Page ${context.pageNumber} of ${context.pagesCount}'),
          ),
          pageFormat: _format,
          build: (ctx) => [
            SizedBox(height: PdfPageFormat.cm * 0.25),
            Align(
              child: Text(
                'Category wise',
                style: TextStyle(font: semibold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: PdfPageFormat.cm),
            Row(
              children: [
                if (category.hasIncome)
                  Expanded(
                    child: Text(
                      'Income',
                      style: TextStyle(font: semibold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (category.hasExpense)
                  Expanded(
                    child: Text(
                      'Expense',
                      style: TextStyle(font: semibold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
            SizedBox(height: PdfPageFormat.cm * 0.5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (category.hasIncome)
                  Expanded(
                    child: Column(
                      children: [
                        Table.fromTextArray(
                          headerAlignment: Alignment.center,
                          headers: ['Category', 'Amount'],
                          headerStyle: TextStyle(font: semibold),
                          headerDecoration:
                              const BoxDecoration(color: PdfColors.green50),
                          cellStyle: TextStyle(font: normal),
                          cellHeight: 30,
                          border: null,
                          oddRowDecoration:
                              const BoxDecoration(color: PdfColors.grey50),
                          columnWidths: {
                            0: const FractionColumnWidth(0.5),
                            1: const FractionColumnWidth(0.5),
                          },
                          cellAlignment: Alignment.center,
                          data: incomeCategories
                              .map(
                                (e) => [
                                  e.categoryName,
                                  format.format(e.amount),
                                ],
                              )
                              .toList(),
                        ),
                        if (incomeCategories.isEmpty)
                          Align(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text('No transactions'),
                            ),
                          ),
                      ],
                    ),
                  ),
                if (category.hasAll) SizedBox(width: PdfPageFormat.cm),
                if (category.hasExpense)
                  Expanded(
                    child: Column(
                      children: [
                        Table.fromTextArray(
                          headerAlignment: Alignment.center,
                          headers: ['Category', 'Amount'],
                          headerStyle: TextStyle(font: semibold),
                          headerDecoration:
                              const BoxDecoration(color: PdfColors.red50),
                          cellStyle: TextStyle(font: normal),
                          cellHeight: 30,
                          border: null,
                          oddRowDecoration:
                              const BoxDecoration(color: PdfColors.grey50),
                          columnWidths: {
                            0: const FractionColumnWidth(0.5),
                            1: const FractionColumnWidth(0.5),
                          },
                          cellAlignment: Alignment.center,
                          data: expenseCategories
                              .map(
                                (e) => [
                                  e.categoryName,
                                  format.format(e.amount),
                                ],
                              )
                              .toList(),
                        ),
                        if (expenseCategories.isEmpty)
                          Align(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text('No transactions'),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    }
    if (!payment.isSinglePayment) {
      final paymentData = _paymentWithExpinsConvert(expins);
      final incomePayments = paymentData.where((e) => e.isIncome).toList();
      final expensePayments = paymentData.where((e) => !e.isIncome).toList();
      pdf.addPage(
        MultiPage(
          header: (context) => _buildHeader(date, bold, normal, icon),
          footer: (context) => Align(
            alignment: Alignment.centerRight,
            child: Text('Page ${context.pageNumber} of ${context.pagesCount}'),
          ),
          pageFormat: _format,
          build: (ctx) => [
            SizedBox(height: PdfPageFormat.cm * 0.25),
            Align(
              child: Text(
                'Payment mode wise',
                style: TextStyle(font: semibold, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: PdfPageFormat.cm),
            Row(
              children: [
                if (category.hasAll || incomePayments.isNotEmpty)
                  Expanded(
                    child: Text(
                      'Income',
                      style: TextStyle(font: semibold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (category.hasAll || expensePayments.isNotEmpty)
                  Expanded(
                    child: Text(
                      'Expense',
                      style: TextStyle(font: semibold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
            SizedBox(height: PdfPageFormat.cm * 0.5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (category.hasAll || incomePayments.isNotEmpty)
                  Expanded(
                    child: Column(
                      children: [
                        Table.fromTextArray(
                          headerAlignment: Alignment.center,
                          headers: ['Payment', 'Amount'],
                          headerStyle: TextStyle(font: semibold),
                          headerDecoration:
                              const BoxDecoration(color: PdfColors.green50),
                          cellStyle: TextStyle(font: normal),
                          cellHeight: 30,
                          border: null,
                          oddRowDecoration:
                              const BoxDecoration(color: PdfColors.grey50),
                          columnWidths: {
                            0: const FractionColumnWidth(0.5),
                            1: const FractionColumnWidth(0.5),
                          },
                          cellAlignment: Alignment.center,
                          data: incomePayments
                              .map(
                                (e) => [
                                  e.paymentName,
                                  format.format(e.amount),
                                ],
                              )
                              .toList(),
                        ),
                        if (incomePayments.isEmpty)
                          Align(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text('No transactions'),
                            ),
                          ),
                      ],
                    ),
                  ),
                if (category.hasAll) SizedBox(width: PdfPageFormat.cm),
                if (category.hasAll || expensePayments.isNotEmpty)
                  Expanded(
                    child: Column(
                      children: [
                        Table.fromTextArray(
                          headerAlignment: Alignment.center,
                          headers: ['Payment', 'Amount'],
                          headerStyle: TextStyle(font: semibold),
                          headerDecoration:
                              const BoxDecoration(color: PdfColors.red50),
                          cellStyle: TextStyle(font: normal),
                          cellHeight: 30,
                          border: null,
                          oddRowDecoration:
                              const BoxDecoration(color: PdfColors.grey50),
                          columnWidths: {
                            0: const FractionColumnWidth(0.5),
                            1: const FractionColumnWidth(0.5),
                          },
                          cellAlignment: Alignment.center,
                          data: expensePayments
                              .map(
                                (e) => [
                                  e.paymentName,
                                  format.format(e.amount),
                                ],
                              )
                              .toList(),
                        ),
                        if (expensePayments.isEmpty)
                          Align(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text('No transactions'),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    }
    return pdf;
  }
}

List<_CategoryWithExpins> _categoryWithExpinsConvert(
    Iterable<IncomeExpense> data) {
  return data
      .reduceToField(
        (item) => item,
        (one, two) => one.categoryId == two.categoryId,
      )
      .map(
        (expin) => _CategoryWithExpins(
          categoryId: expin.categoryId,
          categoryName: expin.categoryName,
          isIncome: expin.isIncome,
          amount: data
              .where((element) => element.categoryId == expin.categoryId)
              .map((e) => e.amount)
              .addition,
        ),
      )
      .toList()
    ..sort((o, t) => -o.amount.compareTo(t.amount));
}

List<_PaymentWithExpins> _paymentWithExpinsConvert(
    Iterable<IncomeExpense> data) {
  final list = data.reduceToField(
      (item) => item, (one, two) => one.paymentId == two.paymentId);
  return [
    ...list.map(
      (expin) => _PaymentWithExpins(
        isIncome: true,
        paymentName: expin.paymentName,
        paymentId: expin.paymentId,
        amount: data
            .where((e) => e.paymentId == expin.paymentId && e.isIncome)
            .map((e) => e.amount)
            .addition,
      ),
    ),
    ...list.map(
      (expin) => _PaymentWithExpins(
        isIncome: false,
        paymentId: expin.paymentId,
        paymentName: expin.paymentName,
        amount: data
            .where((e) => e.paymentId == expin.paymentId && !e.isIncome)
            .map((e) => e.amount)
            .addition,
      ),
    ),
  ]
    ..removeWhere((e) => e.amount <= 0)
    ..sort((o, t) => -o.amount.compareTo(t.amount));
}

class _CategoryWithExpins {
  final int categoryId;
  final String categoryName;
  final bool isIncome;
  final double amount;

  const _CategoryWithExpins({
    required this.categoryId,
    required this.categoryName,
    required this.isIncome,
    required this.amount,
  });
}

class _PaymentWithExpins {
  final int paymentId;
  final String paymentName;
  final bool isIncome;
  final double amount;

  const _PaymentWithExpins({
    required this.paymentId,
    required this.paymentName,
    required this.isIncome,
    required this.amount,
  });
}

class _PdfPreviewPage extends ConsumerWidget {
  const _PdfPreviewPage();

  String buildFileName(String date, String category, String payment) =>
      'Summary-$date-$category-$payment';

  Future<Uint8List> buildPdf({
    required String currency,
    required DateFilter range,
    required CategoryFilter category,
    required PaymentFilter payment,
    required List<ExpinData> expins,
  }) async =>
      (await PdfExportUtils._buildPages(
        currency: currency,
        range: range,
        category: category,
        payment: payment,
        expinDatas: expins,
      ))
          .save();

  @override
  mtl.Widget build(mtl.BuildContext context, WidgetRef ref) {
    final range = ref.watch(TransactionOverviewProvider.dateFilterProvider);
    final category =
        ref.watch(TransactionOverviewProvider.categoryFilterProvider);
    final payment =
        ref.watch(TransactionOverviewProvider.paymentFilterProvider);
    final expins =
        ref.watch(TransactionOverviewProvider.customExpinDatasProvider);
    final name = buildFileName(range.format, category.format, payment.format);
    final build = buildPdf(
      currency: ref.watch(currencyPreferencesProvider),
      range: range,
      category: category,
      payment: payment,
      expins: expins.maybeWhen(orElse: () => [], data: (data) => data),
    );
    return mtl.Scaffold(
      appBar: const CustomAppBar(title: 'Pdf preview'),
      bottomNavigationBar: mtl.Material(
        color: mtl.Theme.of(context).scaffoldBackgroundColor,
        child: mtl.Row(
          mainAxisAlignment: mtl.MainAxisAlignment.spaceEvenly,
          children: [
            mtl.IconButton(
              icon: const mtl.Icon(mtl.Icons.filter_list_rounded),
              onPressed: () => TransactionFilterButton.showCustomFilter(
                context: context,
                read: ref.read,
              ),
            ),
            mtl.IconButton(
              icon: const mtl.Icon(mtl.Icons.print_rounded),
              onPressed: () => Printing.layoutPdf(
                onLayout: (_) => build,
                format: _format,
                name: name,
              ).then((value) {
                if (value) {
                  showSnackBar(
                    const SnackBarData(message: 'Pdf printed successfully'),
                  );
                  mtl.Navigator.pop(context);
                }
              }),
            ),
          ],
        ),
      ),
      body: PdfPreview(
        canDebug: false,
        allowSharing: false,
        allowPrinting: false,
        pdfFileName: name,
        canChangeOrientation: false,
        canChangePageFormat: false,
        build: (_) => build,
        initialPageFormat: PdfPageFormat.a4,
        pageFormats: const {'a4': PdfPageFormat.a4},
      ),
    );
  }
}
