import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../models/loan_transaction.dart';
import '../../repositories/loan_transaction_repository.dart';

class ModifyLoanTransaction {
  final LoanTransactionRepository _repository;

  const ModifyLoanTransaction(this._repository);

  Future<bool> add(LoanTransaction loan) async {
    return _repository.insert(loan).then((value) => value > 0);
  }

  Future<List<int>> addAll(List<LoanTransaction> loans) {
    return _repository.insertAll(loans);
  }

  Future<bool> update(LoanTransaction loan) {
    return _repository.update(loan);
  }

  void _deleteImage(String? path) {
    if (path == null) return;
    try {
      File(path).deleteSync();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> delete(LoanTransaction loan) {
    try {
      _deleteImage(loan.imagePath);
      return _repository.delete(loan);
    } catch (e) {
      return Future.value(false);
    }
  }
}
