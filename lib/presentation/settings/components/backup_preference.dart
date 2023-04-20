import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/preferences_provider.dart';
import '../../../provider/use_cases_provider.dart';
import '../../../utils/backup_and_restore_utils.dart';
import '../../../utils/my_datetime.dart';
import '../../../utils/native_utils.dart';
import '../../app_lock_package/app_lock.dart';
import '../../core_package/core_widget.dart';

class BackupPreference extends ConsumerStatefulWidget {
  const BackupPreference({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BackupPreferenceState createState() => _BackupPreferenceState();
}

class _BackupPreferenceState extends ConsumerState<BackupPreference> {
  bool loading = false;

  Future<String> buildExpins() async {
    final expins = await ref.read(expinUseCasesProvider).getAllExpin.findAll();
    return json.encode(expins.map((e) => e.toJson()).toList());
  }

  Future<String> buildCategories() async {
    final categories =
        await ref.read(categoryUseCasesProvider).getAllCategory.findAll();
    return json.encode(categories.map((e) => e.toJson()).toList());
  }

  Future<String> buildPayments() async {
    final payments =
        await ref.read(paymentUseCasesProvider).getAllPayment.findAll();
    return json.encode(payments.map((e) => e.toJson()).toList());
  }

  Future<String> buildBudgets() async {
    final budgets =
        await ref.read(budgetUseCasesProvider).getAllBudget.findAll();
    return json.encode(budgets.map((e) => e.toJson()).toList());
  }

  Future<String> buildLoans() async {
    final loans = await ref.read(loanUseCasesProvider).getAllLoan.findAll();
    return json.encode(loans.map((e) => e.toJson()).toList());
  }

  Future<String> buildLoanTransactions() async {
    final transactions = await ref
        .read(loanTransactionUseCasesProvider)
        .getAllLoanTransaction
        .findAll();
    return json.encode(transactions.map((e) => e.toJson()).toList());
  }

  String buildPrefs() {
    final currency = ref.read(currencyPreferencesProvider);
    final username = ref.read(usernamePreferencesProvider);
    final lock = ref.read(hasLockPreferencesProvider);
    final password = ref.read(lockPasswordPreferencesProvider);
    final timeout = ref.read(timeoutPreferencesProvider);
    final question = ref.read(securityQuestionPreferencesProvider);
    final answer = ref.read(securityAnswerPreferencesProvider);
    final pinned = ref.read(pinnedCategoryPreferencesProvider);
    final showSavings = ref.read(showSavingsPreferencesProvider);
    final theme = ref.read(themePreferencesProvider);
    final pinBudget = ref.read(pinnedBudgetPreferencesProvider);
    return json.encode([
      jsonEncode(
        {
          'currency': currency,
          'username': username,
          'lock': lock,
          'theme': theme,
          'password': password,
          'timeout': timeout,
          'question': question,
          'answer': answer,
          'pinned': pinned,
          'pin-budget': pinBudget,
          'showSavings': showSavings,
        },
      )
    ]);
  }

  Future<String> buildBackupData() async {
    final expins = await buildExpins();
    final categories = await buildCategories();
    final payments = await buildPayments();
    final budgets = await buildBudgets();
    final prefs = buildPrefs();
    final loans = await buildLoans();
    final transactions = await buildLoanTransactions();
    return json.encode(
      [expins, categories, payments, budgets, prefs, loans, transactions],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !loading,
      child: CustomTile(
        title: 'Backup',
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
            : () async => backupAction(
                  context: context,
                  backupData: await buildBackupData(),
                  localFile:
                      'ExpinBookBackup-${DateTime.now().format('yyyyMMddHHmmss')}.bk',
                  androidVersion: await NativeUtils.getAndroidVersion() ?? 19,
                  loadingChange: (value) => setState(() => loading = value),
                ),
      ),
    );
  }
}
