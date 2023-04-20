import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/use_cases_provider.dart';
import '../../../utils/excel_export_utils.dart';
import '../../core_package/core_widget.dart';

final _isNotEmptyProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(
    expinDataUseCasesProvider.select(
      (e) => e.getAllExpinData.watchAll().map((event) => event.isNotEmpty),
    ),
  ),
);

class ExcelExportPreference extends ConsumerWidget {
  const ExcelExportPreference({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNotEmpty = ref.watch(_isNotEmptyProvider);
    final canExport = isNotEmpty.maybeWhen(
      orElse: () => false,
      data: (data) => data,
    );
    return IgnorePointer(
      ignoring: !canExport,
      child: CustomTile(
        title: 'Export as Excel',
        trailing: Text(
          isNotEmpty.when(
            data: (data) => '',
            error: (error, stackTrace) => 'Error',
            loading: () => 'Loading',
          ),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5),
        onTap: () async {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const AlertDialog(
              content: Text('Loading...', textAlign: TextAlign.center),
            ),
          );
          final navigator = Navigator.of(context);
          var expins = await ref
              .read(expinDataUseCasesProvider)
              .getAllExpinData
              .findAll();
          navigator.pop();
          ExcelExportUtils.saveExcel(
            context: context,
            expinDatas: expins,
          );
        },
      ),
    );
  }
}
