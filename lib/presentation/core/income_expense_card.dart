import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/expin.dart';
import '../../domain/models/expin_data.dart';
import '../../provider/preferences_provider.dart';
import '../../utils/base_extensions.dart';
import '../../utils/my_iterable.dart';
import '../transaction_overview/transaction_overview_page.dart';
import '../transaction_overview/utils/transaction_overview_arg.dart';
import '../utils/category_filter.dart';
import '../utils/date_filter.dart';
import 'currency_text.dart';

const _borderRadius = BorderRadius.all(Radius.circular(15));

@immutable
class _IncomeExpenseWrapper {
  final double amount;
  final int noOfTransactions;

  const _IncomeExpenseWrapper({
    required this.amount,
    required this.noOfTransactions,
  });

  @override
  bool operator ==(covariant _IncomeExpenseWrapper other) {
    if (identical(this, other)) return true;

    return other.amount == amount && other.noOfTransactions == noOfTransactions;
  }

  @override
  int get hashCode => amount.hashCode ^ noOfTransactions.hashCode;
}

class IncomeExpenseCard extends ConsumerWidget {
  final ProviderListenable<AsyncValue<List<Expin>>> expins;
  final DateFilter? filter;
  final bool showNoOfTransactions;
  final bool showSavings;
  final bool showTransfers;
  const IncomeExpenseCard({
    super.key,
    required this.expins,
    this.filter,
    this.showNoOfTransactions = false,
    this.showSavings = false,
    this.showTransfers = false,
  });

  IncomeExpenseCard.fromExpinDatas({
    super.key,
    required ProviderListenable<AsyncValue<List<ExpinData>>> expins,
    this.filter,
    this.showNoOfTransactions = false,
    this.showSavings = false,
    this.showTransfers = false,
  }) : expins = expins.select(
          (value) => value.whenData(
            (value) => value.map((e) => e.expin).toList(),
          ),
        );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (showTransfers) {
      final transfers = ref.watch(
        expins.select(
          (value) => value.whenData(
            (value) => value
                .where((element) => element.isTransfer)
                .map((e) => e.amount)
                .addition,
          ),
        ),
      );
      return transfers.maybeWhen(
        orElse: () => const SizedBox.shrink(),
        data: (transfers) => _TransactionTileCard('Transfers', transfers),
      );
    }
    final incomes = ref.watch(
      expins.select(
        (value) => value.whenData(
          (value) => value
              .where((element) => element.isIncome)
              .map((e) => e.amount)
              .let(
                (value) => _IncomeExpenseWrapper(
                  amount: value.addition,
                  noOfTransactions: value.length,
                ),
              ),
        ),
      ),
    );
    final expenses = ref.watch(
      expins.select(
        (value) => value.whenData(
          (value) => value
              .where((element) => element.isExpense)
              .map((e) => e.amount)
              .let(
                (value) => _IncomeExpenseWrapper(
                  amount: value.addition,
                  noOfTransactions: value.length,
                ),
              ),
        ),
      ),
    );
    final child = Row(
      children: [
        Expanded(
          child: incomes.when(
            data: (incomes) => _TransactionCard(
              key: ValueKey('income ${incomes.amount}'),
              color: Colors.green,
              title: 'Income',
              amount: incomes.amount,
              showNoOfTransactions: showNoOfTransactions,
              noOfTransactions: incomes.noOfTransactions,
              margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
              onTap: filter == null
                  ? null
                  : () => Navigator.pushNamed(
                        context,
                        TransactionOverviewPage.route,
                        arguments: TransactionOverviewArg(
                          dateFilter: filter,
                          categoryFilter: const CategoryFilter.income(),
                        ),
                      ),
            ),
            error: (error, stackTrace) => _TransactionCard.error(
              key: const ValueKey('income error'),
              color: Colors.green,
              title: 'Income',
              error: '$error',
              margin: const EdgeInsets.fromLTRB(20, 0, 15, 0),
            ),
            loading: () => const _TransactionCard.loading(
              key: ValueKey('income loading'),
              color: Colors.green,
              title: 'Income',
              margin: EdgeInsets.fromLTRB(20, 0, 15, 0),
            ),
          ),
        ),
        Expanded(
          child: expenses.when(
            data: (expenses) => _TransactionCard(
              key: ValueKey('expense ${expenses.amount}'),
              showNoOfTransactions: showNoOfTransactions,
              noOfTransactions: expenses.noOfTransactions,
              color: Colors.red,
              title: 'Expense',
              amount: expenses.amount,
              margin: const EdgeInsets.fromLTRB(15, 0, 20, 0),
              onTap: filter == null
                  ? null
                  : () => Navigator.pushNamed(
                        context,
                        TransactionOverviewPage.route,
                        arguments: TransactionOverviewArg(
                          dateFilter: filter,
                          categoryFilter: const CategoryFilter.expense(),
                        ),
                      ),
            ),
            error: (error, stackTrace) => _TransactionCard.error(
              key: const ValueKey('expense error'),
              color: Colors.red,
              title: 'Expense',
              error: '$error',
              margin: const EdgeInsets.fromLTRB(15, 0, 20, 0),
            ),
            loading: () => const _TransactionCard.loading(
              key: ValueKey('expense loading'),
              color: Colors.red,
              title: 'Expense',
              margin: EdgeInsets.fromLTRB(15, 0, 20, 0),
            ),
          ),
        ),
      ],
    );
    if (showSavings) {
      final income = incomes.maybeWhen(
        orElse: () => null,
        data: (data) => data.amount,
      );
      final expense = expenses.maybeWhen(
        orElse: () => null,
        data: (data) => data.amount,
      );
      final savings =
          income != null && expense != null ? income - expense : null;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            child,
            if (savings != null) _TransactionTileCard('Savings', savings),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: child,
      );
    }
  }
}

class _TransactionTileCard extends ConsumerWidget {
  final String title;
  final double value;
  const _TransactionTileCard(this.title, this.value);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!ref.watch(showSavingsPreferencesProvider)) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Row(
        children: [
          const Spacer(),
          Expanded(
            flex: 16,
            child: Material(
              borderRadius: _borderRadius,
              color: Colors.blue.withOpacity(0.15),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    FittedBox(
                      child: CurrencyText(
                        value,
                        style: const TextStyle(
                          fontSize: 18.5,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final Color? color;
  final String title;
  final String? error;
  final bool loading;
  final bool showNoOfTransactions;
  final int noOfTransactions;
  final double amount;
  final VoidCallback? onTap;
  final EdgeInsets margin;
  const _TransactionCard({
    super.key,
    required this.color,
    required this.title,
    required this.amount,
    this.onTap,
    required this.margin,
    required this.noOfTransactions,
    required this.showNoOfTransactions,
  })  : loading = false,
        error = null;

  const _TransactionCard.error({
    super.key,
    required this.color,
    required this.title,
    required String this.error,
    required this.margin,
  })  : amount = 0.0,
        loading = false,
        onTap = null,
        noOfTransactions = 0,
        showNoOfTransactions = false;

  const _TransactionCard.loading({
    super.key,
    required this.color,
    required this.title,
    required this.margin,
  })  : amount = 0.0,
        loading = true,
        error = null,
        onTap = null,
        noOfTransactions = 0,
        showNoOfTransactions = false;

  Widget buildBody() {
    if (loading) return const LinearProgressIndicator();
    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
    if (error?.isNotEmpty == true) {
      return Text(
        error!,
        style: style,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
    return FittedBox(child: CurrencyText(amount, style: style, maxLines: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: InkWell(
        onTap: onTap,
        highlightColor: color?.withOpacity(0.15),
        splashColor: color?.withOpacity(0.15),
        borderRadius: _borderRadius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: _borderRadius,
            color: color?.withOpacity(0.1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: color,
                      fontSize: 15.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(flex: 3),
                  if (onTap != null)
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 11,
                      color: color,
                    ),
                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(height: 8),
              buildBody(),
              if (showNoOfTransactions) const SizedBox(height: 8),
              if (showNoOfTransactions)
                FittedBox(
                  child: Text(
                    noOfTransactions == 1
                        ? '1 transaction'
                        : '$noOfTransactions transactions',
                    maxLines: 1,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
