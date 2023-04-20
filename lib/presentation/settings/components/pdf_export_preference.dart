import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/use_cases_provider.dart';
import '../../../utils/pdf_export_utils.dart';
import '../../core_package/core_widget.dart';

final _isNotEmptyProvider = StreamProvider.autoDispose(
  (ref) => ref.watch(
    expinDataUseCasesProvider.select(
      (value) =>
          value.getAllExpinData.watchAll().map((event) => event.isNotEmpty),
    ),
  ),
);

class PdfExportPreference extends ConsumerWidget {
  const PdfExportPreference({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isNotEmpty = ref.watch(_isNotEmptyProvider);
    final canExport = isNotEmpty.when(
      data: (data) => data,
      error: (error, stackTrace) => false,
      loading: () => false,
    );
    return IgnorePointer(
      ignoring: !canExport,
      child: CustomTile(
        title: 'Export as PDF',
        trailing: Text(
          isNotEmpty.when(
            data: (data) => '',
            error: (error, stackTrace) => 'Error',
            loading: () => 'Loading',
          ),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5),
        onTap: () => PdfExportUtils.savePdf(context),
      ),
    );
  }
}
