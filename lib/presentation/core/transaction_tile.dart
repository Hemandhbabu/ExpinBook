import '../../domain/models/expin.dart';

import '../core_package/core_widget.dart';

import '../add_transaction/add_transaction_arg.dart';
import '../add_transaction/add_transaction_page.dart';
import '../add_transaction/add_transaction_provider.dart';
import '../utils/show_action_utils.dart';
import '../../provider/use_cases_provider.dart';
import '../../utils/my_datetime.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/models/expin_data.dart';
import '../../utils/type_def_utils.dart';
import '../my_impl/custom_date_picker.dart';
import '../utils/dialog_utils.dart';
import 'currency_text.dart';

class TransactionTile extends ConsumerWidget {
  final bool showTimeOnly;
  final ExpinData expinData;
  const TransactionTile({
    super.key,
    required this.expinData,
    this.showTimeOnly = false,
  });

  String format(DateTime date) {
    final timeFormat = DateFormat('hh:mm a').format;
    if (showTimeOnly) return timeFormat(date);
    final now = DateTime.now();
    final format = DateFormat.yMd().format;
    if (format(now) == format(date)) {
      return timeFormat(date);
    } else if (format(now.subtract(const Duration(days: 1))) == format(date)) {
      return 'Yesterday';
    } else {
      return date.dateOrMonthFormat(false, alsoWeek: true);
    }
  }

  void onTap(BuildContext context) => Navigator.pushNamed(
        context,
        AddTransactionPage.route,
        arguments: AddTransactionArg(expinData: expinData),
      );

  void showLongPress(BuildContext context, Reader read) => showCustomAction(
        context,
        tile: this,
        TileActionData(
          actions: const [
            TileAction(
              icon: Icons.copy_rounded,
              text: 'Copy transaction',
              value: 0,
            ),
            TileAction(
              icon: Icons.edit_rounded,
              text: 'Edit transaction',
              iconColor: Colors.blue,
              tileColor: Colors.blue,
              value: 1,
            ),
            TileAction(
              icon: Icons.delete_rounded,
              text: 'Delete transaction',
              iconColor: Colors.red,
              tileColor: Colors.red,
              value: 2,
            ),
          ],
          valueChanged: (value) {
            if (value == 0) {
              showDuplicateSheet(context, read);
            } else if (value == 1) {
              Navigator.pushNamed(
                context,
                AddTransactionPage.route,
                arguments:
                    AddTransactionArg(editable: true, expinData: expinData),
              );
            } else if (value == 2) {
              AddTransactionProvider.delete(context, read, expinData.expin);
            }
          },
        ),
      );

  void showDuplicateSheet(BuildContext context, Reader read) =>
      showCustomDialog(
        context: context,
        title: 'Copy transaction',
        content:
            'Do you want to make a copy of the transaction with same date ?',
        actionsBuilder: (context) => [
          CustomDialogAction(
            text: 'Copy transaction',
            onTap: () {
              Navigator.pop(context);
              read(expinUseCasesProvider).modifyExpin.add(
                    expinData.expin.copyWith(
                      id: -1,
                      dateTime: expinData.expin.dateTime
                          .copyTimeOfDay(TimeOfDay.now()),
                    ),
                  );
            },
          ),
          CustomDialogAction(
            text: 'Pick date',
            onTap: () async {
              Navigator.pop(context);
              final picked = await showCustomDatePicker(
                context: context,
                initialDate: expinData.expin.dateTime,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                confirmText: 'Pick date',
                timeOfDay: TimeOfDay.fromDateTime(expinData.expin.dateTime),
              );
              if (picked != null) {
                await read(expinUseCasesProvider)
                    .modifyExpin
                    .add(expinData.expin.copyWith(id: -1, dateTime: picked));
              }
            },
          ),
          CustomDialogAction(
            text: 'Cancel',
            onTap: () => Navigator.pop(context),
          ),
        ],
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return expinData.when(
      expin: (expinData) => CustomTile(
        maxLines: 1,
        onTap: () => onTap(context),
        onLongPress: () => showLongPress(context, ref.read),
        leadingIcon: expinData.categoryIcon,
        leadingSymbol: expinData.categorySymbol,
        leadingColor: expinData.categoryColor,
        title: expinData.categoryName,
        subtitle: format(expinData.dateTime),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CurrencyText(
              (expinData.isIncome ? 1 : -1) * expinData.amount,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: expinData.isIncome ? Colors.green : null,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  expinData.paymentMode.icon,
                  size: 14.5,
                  color: expinData.paymentColor,
                ),
                if (expinData.description?.isNotEmpty == true) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.notes_rounded, size: 14.5),
                ],
                if (expinData.imagePath != null)
                  const Icon(Icons.attach_file_rounded, size: 12.5),
              ],
            ),
          ],
        ),
      ),
      transfer: (expinData) {
        return CustomTile(
          maxLines: 1,
          onTap: () => onTap(context),
          onLongPress: () => showLongPress(context, ref.read),
          leadingIcon: TransactionType.transfer.icon,
          leadingColor: TransactionType.transfer.color,
          title: 'Transfer',
          subtitle: format(expinData.dateTime),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CurrencyText(
                expinData.amount,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    expinData.fromPaymentMode.icon,
                    size: 14.5,
                    color: expinData.fromPaymentColor,
                  ),
                  const SizedBox(width: 1),
                  const Icon(Icons.arrow_forward_rounded, size: 10),
                  const SizedBox(width: 1),
                  Icon(
                    expinData.toPaymentMode.icon,
                    size: 14.5,
                    color: expinData.toPaymentColor,
                  ),
                  if (expinData.description?.isNotEmpty == true) ...[
                    const SizedBox(width: 4),
                    const Icon(Icons.notes_rounded, size: 14.5),
                  ],
                  if (expinData.imagePath != null)
                    const Icon(Icons.attach_file_rounded, size: 12.5),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
