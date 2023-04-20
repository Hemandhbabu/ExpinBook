import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/category.dart';
import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import '../../utils/category_data.dart';
import '../../utils/snack_bar_data.dart';
import '../../utils/snack_bar_utils.dart';
import '../../utils/type_def_utils.dart';
import '../utils/dialog_utils.dart';

class AddCategoryProvider {
  AddCategoryProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final editableProvider = StateProvider.autoDispose((ref) => true);

  static final nameProvider = StateProvider.autoDispose((ref) => '');

  static final isIncomeProvider = StateProvider.autoDispose((ref) => true);

  static final iconProvider = StateProvider.autoDispose<IconData?>(
      (ref) => categoryIcons[Random().nextInt(categoryIcons.length)]);

  static final symbolProvider =
      StateProvider.autoDispose<String?>((ref) => null);

  static final colorProvider = StateProvider.autoDispose(
      (ref) => categoryColors[Random().nextInt(categoryColors.length)]);

  static final descriptionProvider = StateProvider.autoDispose((ref) => '');

  static final validatorProvider = Provider.autoDispose.family(validator);

  static bool validator(AutoDisposeProviderRef ref, Category? category) {
    final name = ref.watch(nameProvider);
    final icon = ref.watch(iconProvider);
    final symbol = ref.watch(symbolProvider);
    final isIncome = ref.watch(isIncomeProvider);
    final color = ref.watch(colorProvider);
    final description = ref.watch(descriptionProvider);
    var result = name.isNotEmpty;
    if (result) result = icon != null || symbol?.isNotEmpty == true;
    if (category == null) return result;
    if (result) {
      return Category(
            id: category.id,
            name: name,
            isIncome: isIncome,
            iconIndex: icon?.let((icon) => categoryIcons.indexOf(icon)),
            symbol: symbol?.let((value) => value.isEmpty ? null : value),
            color: color,
            description:
                description.let((value) => value.isEmpty ? null : value),
          ) !=
          category;
    } else {
      return false;
    }
  }

  static void save(BuildContext context, Reader read, int id) {
    final category = Category(
      id: id > 0 ? id : null,
      name: read(nameProvider),
      isIncome: read(isIncomeProvider),
      iconIndex: read(iconProvider)?.let(categoryIcons.indexOf),
      symbol:
          read(symbolProvider)?.let((value) => value.isEmpty ? null : value),
      color: read(colorProvider),
      description: read(descriptionProvider)
          .let((value) => value.isEmpty ? null : value),
    );
    final dao = read(categoryUseCasesProvider);
    if (id > 0) {
      dao.modifyCategory.update(category).then(
        (value) {
          if (value) Navigator.pop(context);
          showSnackBar(
            SnackBarData(
              message: value
                  ? 'Category updated successfully'
                  : 'Error while updating category',
            ),
          );
        },
      );
    } else {
      dao.modifyCategory.add(category).then(
        (value) {
          if (value) Navigator.pop(context);
          showSnackBar(
            SnackBarData(
              message: value
                  ? 'Category added successfully'
                  : 'Error while adding category',
            ),
          );
        },
      );
    }
  }

  static Future<bool?> delete(
          BuildContext context, Reader read, Category category) =>
      showCustomDialog(
        context: context,
        title: 'Are you sure ?',
        content: 'Do you want to delete this category ?\n\nNote :\n'
            'Deleting this category will modify the transaction with this category to "Others"',
        actionsBuilder: (context) => [
          CustomDialogAction(
            text: 'No',
            onTap: () => Navigator.pop(context),
          ),
          CustomDialogAction(
            text: 'Yes',
            onTap: () {
              Navigator.pop(context, true);
              read(categoryUseCasesProvider).modifyCategory.delete(category);

              showSnackBar(
                const SnackBarData(message: 'Category deleted'),
              );
            },
          ),
        ],
      );
}
