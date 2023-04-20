import 'dart:convert';

import '../../../domain/models/loan_transaction.dart';

import '../../../domain/models/loan.dart';
import '../../app_lock_package/app_lock.dart';
import '../../core_package/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/budget.dart';
import '../../../domain/models/category.dart';
import '../../../domain/models/expin.dart';
import '../../../domain/models/payment.dart';
import '../../../provider/preferences_provider.dart';
import '../../../provider/use_cases_provider.dart';
import '../../../utils/backup_and_restore_utils.dart';
import '../../../utils/snack_bar_data.dart';
import '../../../utils/snack_bar_utils.dart';
import '../../../utils/type_def_utils.dart';

class RestorePreference extends ConsumerStatefulWidget {
  const RestorePreference({Key? key}) : super(key: key);

  static Future<bool> restore(Reader read, String restoredData) async {
    try {
      final value = (json.decode(restoredData) as List).cast<String>();
      final data =
          value.map((e) => (json.decode(e) as List).cast<String>()).toList();
      await read(categoryUseCasesProvider)
          .modifyCategory
          .addAll(_buildCategories(data[1]));
      await read(paymentUseCasesProvider)
          .modifyPayment
          .addAll(_buildPayments(data[2]));
      await read(expinUseCasesProvider)
          .modifyExpin
          .addAll(_buildExpins(data[0]));
      await read(budgetUseCasesProvider)
          .modifyBudget
          .addAll(_buildBudgets(data[3]));
      await _restorePrefs(read, data[4][0]);
      await read(loanUseCasesProvider).modifyLoan.addAll(_buildLoans(data[5]));
      await read(loanTransactionUseCasesProvider)
          .modifyLoanTransaction
          .addAll(_buildLoanTransactions(data[6]));
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static List<Expin> _buildExpins(List<String> value) =>
      value.map((e) => Expin.fromJson(e)).toList();

  static List<Category> _buildCategories(List<String> value) =>
      value.map((e) => Category.fromJson(e)).toList();

  static List<Payment> _buildPayments(List<String> value) =>
      value.map((e) => Payment.fromJson(e)).toList();

  static List<Budget> _buildBudgets(List<String> value) =>
      value.map((e) => Budget.fromJson(e)).toList();

  static List<Loan> _buildLoans(List<String> value) =>
      value.map((e) => Loan.fromJson(e)).toList();

  static List<LoanTransaction> _buildLoanTransactions(List<String> value) =>
      value.map((e) => LoanTransaction.fromJson(e)).toList();

  static Future<void> _restorePrefs(Reader read, String json) async {
    final map = (jsonDecode(json) as Map).cast<String, dynamic>();
    final currency = map['currency'] as String?;
    if (currency != null) {
      await read(currencyPreferencesProvider.notifier).setString(currency);
    }
    final username = map['username'] as String?;
    if (username != null) {
      await read(usernamePreferencesProvider.notifier).setString(username);
    }
    final lock = map['lock'] as bool?;
    if (lock != null) {
      await read(hasLockPreferencesProvider.notifier).setBool(lock);
    }
    final password = map['password'] as String?;
    if (password != null) {
      await read(lockPasswordPreferencesProvider.notifier).setString(password);
    }
    final timeout = map['timeout'] as int?;
    if (timeout != null) {
      await read(timeoutPreferencesProvider.notifier).setInt(timeout);
    }
    final question = map['question'] as int?;
    if (question != null) {
      await read(securityQuestionPreferencesProvider.notifier).setInt(question);
    }
    final answer = map['answer'] as String?;
    if (answer != null) {
      await read(securityAnswerPreferencesProvider.notifier).setString(answer);
    }
    final pinned = map['pinned'] as String?;
    if (pinned != null) {
      await read(pinnedCategoryPreferencesProvider.notifier).setString(pinned);
    }
    final showSavings = map['showSavings'] as bool?;
    if (showSavings != null) {
      await read(showSavingsPreferencesProvider.notifier).setBool(showSavings);
    }
    final theme = map['theme'] as int?;
    if (theme != null) {
      await read(themePreferencesProvider.notifier).setInt(theme);
    }
    final pinBudget = map['pin-budget'] as int?;
    if (pinBudget != null) {
      await read(pinnedBudgetPreferencesProvider.notifier).setInt(pinBudget);
    }
  }

  @override
  // ignore: library_private_types_in_public_api
  _RestorePreferenceState createState() => _RestorePreferenceState();
}

class _RestorePreferenceState extends ConsumerState<RestorePreference> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return CustomTile(
      title: 'Restore',
      padding: const EdgeInsets.symmetric(vertical: 5),
      trailing: loading
          ? const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator.adaptive(strokeWidth: 3),
            )
          : null,
      onTap: loading
          ? null
          : () async {
              final expinsEmpty =
                  (await ref.read(expinUseCasesProvider).getAllExpin.findAll())
                      .isEmpty;
              final budgetsEmpty = (await ref
                      .read(budgetUseCasesProvider)
                      .getAllBudget
                      .findAll())
                  .isEmpty;
              if (expinsEmpty && budgetsEmpty) {
                restoreAction(
                  context: context,
                  restore: (value) =>
                      RestorePreference.restore(ref.read, value),
                  loadingChange: (value) => setState(() => loading = value),
                );
              } else {
                showSnackBar(
                  const SnackBarData(
                    message:
                        'Restore can be only done when there is no transactions and budgets',
                  ),
                );
              }
            },
    );
  }
}
