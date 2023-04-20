import 'dart:async';

import 'daos/loan_dao.dart';
import 'daos/loan_transaction_dao.dart';
import '../../domain/models/loan.dart';
import '../../domain/models/loan_transaction.dart';
import 'package:floor/floor.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../domain/models/budget.dart';
import '../../domain/models/category.dart';
import '../../domain/models/expin.dart';
import '../../domain/models/payment.dart';
import 'daos/budget_dao.dart';
import 'daos/category_dao.dart';
import 'daos/expin_dao.dart';
import 'daos/payment_dao.dart';
import 'type_converters.dart';

part 'expin_book_database.g.dart';

@Database(
  version: 1,
  entities: [Category, Payment, Expin, Budget, Loan, LoanTransaction],
)
@TypeConverters(
  [
    DateTimeConverter,
    ColorConverter,
    PaymentModeConverter,
    TransactionTypeConverter,
    IntListConverter,
  ],
)
abstract class ExpinBookDatabase extends FloorDatabase {
  CategoryDao get categoryDao;
  PaymentDao get paymentDao;
  ExpinDao get expinDao;
  BudgetDao get budgetDao;
  LoanDao get loanDao;
  LoanTransactionDao get loanTransactionDao;
}
