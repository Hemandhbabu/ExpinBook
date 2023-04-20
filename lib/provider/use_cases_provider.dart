import '../domain/use_cases/loan/loan_use_cases.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../data/database/database_data.dart';
import '../data/database/expin_book_database.dart';
import '../data/repositories/budget_repository_impl.dart';
import '../data/repositories/category_repository_impl.dart';
import '../data/repositories/expin_data_repository_impl.dart';
import '../data/repositories/expin_repository_impl.dart';
import '../data/repositories/loan_repository_impl.dart';
import '../data/repositories/loan_transaction_repository_impl.dart';
import '../data/repositories/payment_repository_impl.dart';
import '../domain/use_cases/budget/budget_use_cases.dart';
import '../domain/use_cases/budget/get_all_budget.dart';
import '../domain/use_cases/budget/get_budget.dart';
import '../domain/use_cases/budget/modify_budget.dart';
import '../domain/use_cases/category/category_use_cases.dart';
import '../domain/use_cases/category/get_all_category.dart';
import '../domain/use_cases/category/get_category.dart';
import '../domain/use_cases/category/modify_category.dart';
import '../domain/use_cases/expin/expin_use_cases.dart';
import '../domain/use_cases/expin/get_all_expin.dart';
import '../domain/use_cases/expin/get_expin.dart';
import '../domain/use_cases/expin/modify_expin.dart';
import '../domain/use_cases/expin_data/expin_data_use_cases.dart';
import '../domain/use_cases/expin_data/get_all_expin_data.dart';
import '../domain/use_cases/expin_data/get_expin_data.dart';
import '../domain/use_cases/loan/get_all_loan.dart';
import '../domain/use_cases/loan/get_loan.dart';
import '../domain/use_cases/loan/modify_loan.dart';
import '../domain/use_cases/loan_transaction/get_all_loan_transaction.dart';
import '../domain/use_cases/loan_transaction/get_loan_transaction.dart';
import '../domain/use_cases/loan_transaction/loan_transaction_use_cases.dart';
import '../domain/use_cases/loan_transaction/modify_loan_transaction.dart';
import '../domain/use_cases/payment/get_all_payment.dart';
import '../domain/use_cases/payment/get_payment.dart';
import '../domain/use_cases/payment/modify_payment.dart';
import '../domain/use_cases/payment/payment_use_cases.dart';

late final ExpinBookDatabase _db;

Future<void> initializeDatabase() async => _db = await $FloorExpinBookDatabase
    .databaseBuilder('expin_book.db')
    .addCallback(callback())
    .build();

final _expinRepositoryProvider = Provider.autoDispose(
  (ref) => ExpinRepositoryImpl(_db.expinDao),
);
final _expinDataRepositoryProvider = Provider.autoDispose(
  (ref) => ExpinDataRepositoryImpl(
    _db.expinDao,
    _db.categoryDao,
    _db.paymentDao,
  ),
);
final _categoryRepositoryProvider = Provider.autoDispose(
  (ref) => CategoryRepositoryImpl(_db.categoryDao),
);
final _paymentRepositoryProvider = Provider.autoDispose(
  (ref) => PaymentRepositoryImpl(_db.paymentDao),
);
final _budgetRepositoryProvider = Provider.autoDispose(
  (ref) => BudgetRepositoryImpl(_db.budgetDao),
);
final _loanRepositoryProvider = Provider.autoDispose(
  (ref) => LoanRepositoryImpl(_db.loanDao),
);
final _loanTransactionRepositoryProvider = Provider.autoDispose(
  (ref) => LoanTransactionRepositoryImpl(_db.loanTransactionDao),
);

final expinUseCasesProvider = Provider.autoDispose(
  (ref) {
    final rep = ref.watch(_expinRepositoryProvider);
    return ExpinUseCases(
      modifyExpin: ModifyExpin(rep),
      getExpin: GetExpin(rep),
      getAllExpin: GetAllExpin(rep),
    );
  },
);
final expinDataUseCasesProvider = Provider.autoDispose(
  (ref) {
    final rep = ref.watch(_expinDataRepositoryProvider);
    return ExpinDataUseCases(
      getExpinData: GetExpinData(rep),
      getAllExpinData: GetAllExpinData(rep),
    );
  },
);
final categoryUseCasesProvider = Provider.autoDispose(
  (ref) {
    final rep = ref.watch(_categoryRepositoryProvider);
    return CategoryUseCases(
      modifyCategory: ModifyCategory(
        rep,
        ref.watch(_expinRepositoryProvider),
        ref.watch(_budgetRepositoryProvider),
      ),
      getCategory: GetCategory(rep),
      getAllCategory: GetAllCategory(rep),
    );
  },
);
final paymentUseCasesProvider = Provider.autoDispose(
  (ref) {
    final rep = ref.watch(_paymentRepositoryProvider);
    return PaymentUseCases(
      modifyPayment: ModifyPayment(
        rep,
        ref.watch(_expinRepositoryProvider),
      ),
      getPayment: GetPayment(rep),
      getAllPayment: GetAllPayment(rep),
    );
  },
);
final budgetUseCasesProvider = Provider.autoDispose(
  (ref) {
    final rep = ref.watch(_budgetRepositoryProvider);
    return BudgetUseCases(
      modifyBudget: ModifyBudget(rep),
      getBudget: GetBudget(rep),
      getAllBudget: GetAllBudget(rep),
    );
  },
);
final loanUseCasesProvider = Provider.autoDispose(
  (ref) {
    final rep = ref.watch(_loanRepositoryProvider);
    return LoanUseCases(
      modifyLoan:
          ModifyLoan(rep, ref.watch(_loanTransactionRepositoryProvider)),
      getLoan: GetLoan(rep),
      getAllLoan: GetAllLoan(rep),
    );
  },
);
final loanTransactionUseCasesProvider = Provider.autoDispose(
  (ref) {
    final rep = ref.watch(_loanTransactionRepositoryProvider);
    return LoanTransactionUseCases(
      modifyLoanTransaction: ModifyLoanTransaction(rep),
      getLoanTransaction: GetLoanTransaction(rep),
      getAllLoanTransaction: GetAllLoanTransaction(rep),
    );
  },
);
