import 'package:intl/intl.dart';

import '../../domain/models/loan.dart';
import '../../domain/models/loan_transaction.dart';
import '../../utils/my_datetime.dart';
import '../../utils/my_iterable.dart';

class LoanDetailData {
  final Loan loan;
  final List<LoanTransaction> transactions;
  final double totalLoan;
  final double paidAmount;
  final double leftToPay;

  LoanDetailData({
    required this.loan,
    required this.transactions,
  })  : totalLoan = transactions
            .where((element) => !element.isPay)
            .map((e) => e.amount)
            .addition,
        paidAmount = transactions
            .where((element) => element.isPay)
            .map((e) => e.amount)
            .addition,
        leftToPay = _leftToPay(loan, transactions);

  static double _leftToPay(Loan loan, List<LoanTransaction> transactions) {
    final totalLoan = transactions
        .where((element) => !element.isPay)
        .map((e) => e.amount)
        .addition;
    if (totalLoan <= 0) return 0;
    final now = DateTime.now();
    var date =
        transactions.isEmpty ? loan.dateTime : transactions.last.dateTime;
    if (now.year <= date.year && now.month <= date.month) {
      final paidAmount = transactions
          .where((element) => element.isPay)
          .map((e) => e.amount)
          .addition;
      return totalLoan - paidAmount;
    }
    final format = DateFormat('yyyyMM').format;
    var left = 0.0;
    final amountAtFirst = transactions
        .where((element) => format(date) == format(element.dateTime))
        .map((e) => e.amount * (e.isPay ? 1 : -1))
        .addition;
    left -= amountAtFirst;
    while (format(now) != format(date)) {
      date = date.addMonth(1);
      final amountAtMonth = transactions
          .where((element) => format(date) == format(element.dateTime))
          .map((e) => e.amount * (e.isPay ? 1 : -1))
          .addition;
      final interest =
          double.parse((left * (loan.interest / 100 / 12)).toStringAsFixed(2));
      left = left - amountAtMonth + interest;
      left = double.parse(left.toStringAsFixed(2));
    }
    return left < 0 ? 0 : left;
  }
}
