import 'dart:math';

import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/loan.dart';
import '../../utils/category_data.dart';
import '../../utils/snack_bar_data.dart';
import '../../utils/snack_bar_utils.dart';
import '../../utils/type_def_utils.dart';
import '../utils/dialog_utils.dart';

class AddLoanProvider {
  const AddLoanProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final nameProvider = StateProvider.autoDispose((ref) => '');

  static final interestProvider = StateProvider.autoDispose((ref) => 0.0);

  static final dateProvider =
      StateProvider.autoDispose((ref) => DateTime.now());

  static final iconProvider = StateProvider.autoDispose<IconData?>(
      (ref) => categoryIcons[Random().nextInt(categoryIcons.length)]);

  static final symbolProvider =
      StateProvider.autoDispose<String?>((ref) => null);

  static final colorProvider = StateProvider.autoDispose(
      (ref) => categoryColors[Random().nextInt(categoryColors.length)]);

  static final descriptionProvider = StateProvider.autoDispose((ref) => '');

  static final validatorProvider = Provider.autoDispose.family(validator);

  static bool validator(AutoDisposeProviderRef ref, Loan? loan) {
    final name = ref.watch(nameProvider);
    final icon = ref.watch(iconProvider);
    final symbol = ref.watch(symbolProvider);
    final color = ref.watch(colorProvider);
    final description = ref.watch(descriptionProvider);
    final interest = ref.watch(interestProvider);
    final date = ref.watch(dateProvider);
    var result = name.isNotEmpty;
    if (result) result = icon != null || symbol?.isNotEmpty == true;
    if (loan == null) return result;
    if (result) {
      return Loan(
            id: loan.id,
            name: name,
            dateTime: date,
            interest: interest.let((value) => value < 0 ? 0.0 : value),
            iconIndex: icon?.let((icon) => categoryIcons.indexOf(icon)),
            symbol: symbol?.let((value) => value.isEmpty ? null : value),
            color: color,
            description:
                description.let((value) => value.isEmpty ? null : value),
          ) !=
          loan;
    } else {
      return false;
    }
  }

  static void save(BuildContext context, Reader read, int id) {
    final loan = Loan(
      id: id > 0 ? id : null,
      name: read(nameProvider),
      interest: read(interestProvider),
      dateTime: read(dateProvider),
      iconIndex: read(iconProvider)?.let(categoryIcons.indexOf),
      symbol:
          read(symbolProvider)?.let((value) => value.isEmpty ? null : value),
      color: read(colorProvider),
      description: read(descriptionProvider)
          .let((value) => value.isEmpty ? null : value),
    );
    final dao = read(loanUseCasesProvider);
    if (id > 0) {
      dao.modifyLoan.update(loan).then(
        (value) {
          if (value) Navigator.pop(context);
          showSnackBar(
            SnackBarData(
              message: value
                  ? 'Loan updated successfully'
                  : 'Error while updating loan',
            ),
          );
        },
      );
    } else {
      dao.modifyLoan.add(loan).then(
        (value) {
          if (value) Navigator.pop(context);
          showSnackBar(
            SnackBarData(
              message:
                  value ? 'Loan added successfully' : 'Error while adding loan',
            ),
          );
        },
      );
    }
  }

  static Future<bool?> delete(BuildContext context, Reader read, Loan loan) =>
      showCustomDialog(
        context: context,
        title: 'Are you sure ?',
        content: 'Do you want to delete this loan ?\n\nNote :\n'
            'Deleting this loan will delete the transaction with this loan',
        actionsBuilder: (context) => [
          CustomDialogAction(
            text: 'No',
            onTap: () => Navigator.pop(context),
          ),
          CustomDialogAction(
            text: 'Yes',
            onTap: () {
              Navigator.pop(context, true);
              read(loanUseCasesProvider).modifyLoan.delete(loan);

              showSnackBar(
                const SnackBarData(message: 'Loan deleted'),
              );
            },
          ),
        ],
      );
}
