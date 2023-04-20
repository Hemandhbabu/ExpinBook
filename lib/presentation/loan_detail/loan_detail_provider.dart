import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/use_cases_provider.dart';
import '../../utils/base_extensions.dart';
import 'loan_detail_data.dart';

class LoanDetailProvider {
  const LoanDetailProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final _loanProvider = StreamProvider.autoDispose.family(
    (ref, int id) => ref.watch(loanUseCasesProvider).getLoan.watchWithId(id),
  );

  static final _loanTransactionsProvider = StreamProvider.autoDispose.family(
    (ref, int id) => ref
        .watch(loanTransactionUseCasesProvider)
        .getAllLoanTransaction
        .watchAllWithLoanId(id),
  );

  static final loanDetailProvider = Provider.autoDispose.family(
    (ref, int id) {
      final loan = ref.watch(_loanProvider(id));
      final transactions = ref.watch(_loanTransactionsProvider(id));
      return loan.merge(
        (loan) => transactions.whenData(
          (transactions) => loan == null
              ? null
              : LoanDetailData(loan: loan, transactions: transactions),
        ),
      );
    },
  );
}
