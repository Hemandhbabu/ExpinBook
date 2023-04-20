import 'package:flutter/material.dart';

import '../domain/models/loan.dart';
import '../presentation/add_budget/add_budget_arg.dart';
import '../presentation/add_budget/add_budget_page.dart';
import '../presentation/add_category/add_category_arg.dart';
import '../presentation/add_category/add_category_page.dart';
import '../presentation/add_loan/add_loan_arg.dart';
import '../presentation/add_loan/add_loan_page.dart';
import '../presentation/add_loan_transaction/add_loan_transaction_arg.dart';
import '../presentation/add_loan_transaction/add_loan_transaction_page.dart';
import '../presentation/add_payment/add_payment_arg.dart';
import '../presentation/add_payment/add_payment_page.dart';
import '../presentation/add_transaction/add_transaction_arg.dart';
import '../presentation/add_transaction/add_transaction_page.dart';
import '../presentation/all_transactions/all_transactions_page.dart';
import '../presentation/app_lock_package/app_lock/app_lock_arg.dart';
import '../presentation/app_lock_package/app_lock/app_lock_page.dart';
import '../presentation/app_lock_package/app_lock/utils/app_lock_data.dart';
import '../presentation/app_lock_package/security_question/security_question_page.dart';
import '../presentation/budget_detail/budget_detail_page.dart';
import '../presentation/budgets/budgets_page.dart';
import '../presentation/categories/categories_page.dart';
import '../presentation/category_analysis/category_analysis_page.dart';
import '../presentation/category_analysis/utils/category_analysis_arg.dart';
import '../presentation/category_overview/category_overview_page.dart';
import '../presentation/dashboard/dashboard_page.dart';
import '../presentation/loan_detail/loan_detail_page.dart';
import '../presentation/loan_transactions/loan_transactions_page.dart';
import '../presentation/loans/loans_page.dart';
import '../presentation/main_page.dart';
import '../presentation/payment_overview/payment_overview_page.dart';
import '../presentation/payments/payments_page.dart';
import '../presentation/pinned_categories/components/manage_pinned_categories.dart';
import '../presentation/pinned_categories/pinned_categories_page.dart';
import '../presentation/search_transaction/search_transaction_page.dart';
import '../presentation/settings/settings_page.dart';
import '../presentation/transaction_overview/transaction_overview_page.dart';
import '../presentation/transaction_overview/utils/transaction_overview_arg.dart';

const initialRoute = MainPage.route;

Map<String, Widget Function(BuildContext context)> routes() => {
      MainPage.route: (context) => const MainPage(),
      AllTransactionsPage.route: (context) => const AllTransactionsPage(),
      SearchTransactionPage.route: (context) => const SearchTransactionPage(),
      CategoriesPage.route: (context) => const CategoriesPage(),
      PaymentsPage.route: (context) => const PaymentsPage(),
      PinnedCategoriesPage.route: (context) => const PinnedCategoriesPage(),
      ManagePinnedCategories.route: (context) => const ManagePinnedCategories(),
      CategoryOverviewPage.route: (context) => const CategoryOverviewPage(),
      PaymentOverviewPage.route: (context) => const PaymentOverviewPage(),
      BudgetsPage.route: (context) => const BudgetsPage(),
      LoansPage.route: (context) => const LoansPage(),
      SettingsPage.route: (context) => const SettingsPage(),
      DashboardPage.route: (context) => const DashboardPage(),
      AppLockPage.route: (context) {
        final arguments =
            ModalRoute.of(context)?.settings.arguments as AppLockArg?;
        return AppLockPage(
          data: arguments?.data ?? const AppLockData.verify(),
          forceClose: arguments?.useForceClose ?? false,
        );
      },
      SecurityQuestionPage.route: (context) {
        final arguments = ModalRoute.of(context)?.settings.arguments as bool?;
        return SecurityQuestionPage(verify: arguments ?? true);
      },
      TransactionOverviewPage.route: (context) {
        final arguments = ModalRoute.of(context)?.settings.arguments
            as TransactionOverviewArg?;
        return TransactionOverviewPage(
          dateFilter: arguments?.dateFilter,
          categoryFilter: arguments?.categoryFilter,
          paymentFilter: arguments?.paymentFilter,
        );
      },
      AddTransactionPage.route: (context) {
        final arguments =
            ModalRoute.of(context)?.settings.arguments as AddTransactionArg?;
        return AddTransactionPage(
          expinData: arguments?.expinData,
          editable: arguments?.editable ?? false,
        );
      },
      AddCategoryPage.route: (context) {
        final arguments =
            ModalRoute.of(context)?.settings.arguments as AddCategoryArg?;
        return AddCategoryPage(
          category: arguments?.category,
          editable: arguments?.editable ?? false,
        );
      },
      AddPaymentPage.route: (context) {
        final arguments =
            ModalRoute.of(context)?.settings.arguments as AddPaymentArg?;
        return AddPaymentPage(
          payment: arguments?.payment,
          editable: arguments?.editable ?? false,
        );
      },
      AddBudgetPage.route: (context) {
        final arguments =
            ModalRoute.of(context)?.settings.arguments as AddBudgetArg?;
        return AddBudgetPage(
          budget: arguments?.budget,
        );
      },
      AddLoanPage.route: (context) {
        final arguments =
            ModalRoute.of(context)?.settings.arguments as AddLoanArg?;
        return AddLoanPage(
          loan: arguments?.loan,
        );
      },
      AddLoanTransactionPage.route: (context) {
        final arguments = ModalRoute.of(context)?.settings.arguments
            as AddLoanTransactionArg?;
        return AddLoanTransactionPage(
          editable: arguments?.editable ?? false,
          loanId: arguments?.loanId ?? -1,
          transaction: arguments?.transaction,
        );
      },
      BudgetDetailPage.route: (context) {
        final arguments = ModalRoute.of(context)?.settings.arguments as int?;
        return BudgetDetailPage(id: arguments ?? -1);
      },
      LoanDetailPage.route: (context) {
        final arguments = ModalRoute.of(context)?.settings.arguments as int?;
        return LoanDetailPage(id: arguments ?? -1);
      },
      LoanTransactionsPage.route: (context) {
        final loan = ModalRoute.of(context)?.settings.arguments as Loan?;
        if (loan == null) {
          Future.delayed(Duration.zero, () => Navigator.pop(context));
          return const Material();
        }
        return LoanTransactionsPage(loan: loan);
      },
      CategoryAnalysisPage.route: (context) {
        final arguments =
            ModalRoute.of(context)!.settings.arguments as CategoryAnalysisArg;
        return CategoryAnalysisPage(
          dateFilter: arguments.dateFilter,
          category: arguments.category,
        );
      }
    };
