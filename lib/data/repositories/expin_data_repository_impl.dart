import 'package:rxdart/rxdart.dart';

import '../../domain/models/category.dart';
import '../../domain/models/expin.dart';
import '../../domain/models/expin_data.dart';
import '../../domain/models/payment.dart';
import '../../domain/repositories/expin_data_repository.dart';
import '../../utils/my_iterable.dart';
import '../database/daos/category_dao.dart';
import '../database/daos/expin_dao.dart';
import '../database/daos/payment_dao.dart';

class ExpinDataRepositoryImpl with ExpinDataRepository {
  final ExpinDao _dao;
  final CategoryDao _categoryDao;
  final PaymentDao _paymentDao;

  const ExpinDataRepositoryImpl(this._dao, this._categoryDao, this._paymentDao);

  ExpinData _buildExpinDataExpin(
          Expin expin, Category category, Payment payment) =>
      ExpinData.expin(
        IncomeExpense(
          id: expin.id!,
          amount: expin.amount,
          categoryId: expin.categoryId,
          dateTime: expin.dateTime,
          description: expin.description,
          imagePath: expin.imagePath,
          isIncome: expin.isIncome,
          paymentId: expin.paymentId,
          categoryName: category.name,
          categoryIconIndex: category.iconIndex,
          categorySymbol: category.symbol,
          categoryColor: category.color,
          paymentName: payment.name,
          paymentMode: payment.mode,
          paymentColor: payment.color,
        ),
      );

  ExpinData _buildExpinDataTransfer(Expin expin, Payment from, Payment to) =>
      ExpinData.transfer(
        Transfer(
          id: expin.id!,
          amount: expin.amount,
          dateTime: expin.dateTime,
          description: expin.description,
          imagePath: expin.imagePath,
          fromPaymentColor: from.color,
          fromPaymentId: from.id!,
          fromPaymentMode: from.mode,
          fromPaymentName: from.name,
          toPaymentColor: to.color,
          toPaymentId: to.id!,
          toPaymentMode: to.mode,
          toPaymentName: to.name,
        ),
      );

  Future<ExpinData?> _getExpinData(Expin expin) async {
    if (expin.isTransfer) {
      final toId = expin.toPaymentId;
      if (toId == null) return null;
      final from = await _paymentDao.findPaymentWithId(expin.paymentId);
      if (from == null) return null;
      final to = await _paymentDao.findPaymentWithId(toId);
      if (to == null) return null;
      return _buildExpinDataTransfer(expin, from, to);
    } else {
      final category = await _categoryDao.findCategoryWithId(expin.categoryId);
      if (category == null) return null;
      final payment = await _paymentDao.findPaymentWithId(expin.paymentId);
      if (payment == null) return null;
      return _buildExpinDataExpin(expin, category, payment);
    }
  }

  Stream<ExpinData?> _watchExpinData(Expin expin) {
    if (expin.isTransfer) {
      if (expin.toPaymentId == null) return Stream.value(null);
      return Rx.combineLatest2(
        _paymentDao.watchPaymentWithId(expin.paymentId),
        _paymentDao.watchPaymentWithId(expin.toPaymentId!),
        (from, to) {
          if (from == null || to == null) return null;
          return _buildExpinDataTransfer(expin, from, to);
        },
      );
    } else {
      return Rx.combineLatest2(
        _categoryDao.watchCategoryWithId(expin.categoryId),
        _paymentDao.watchPaymentWithId(expin.paymentId),
        (category, payment) {
          if (category == null || payment == null) return null;
          return _buildExpinDataExpin(expin, category, payment);
        },
      );
    }
  }

  @override
  Future<ExpinData?> findWithId(int id) async {
    final expin = await _dao.findExpinWithId(id);
    if (expin == null) return null;
    return _getExpinData(expin);
  }

  @override
  Stream<ExpinData?> watchWithId(int id) {
    return _dao.watchExpinWithId(id).switchMap(
      (expin) {
        if (expin == null) return Stream.value(null);
        return _watchExpinData(expin);
      },
    );
  }

  @override
  Future<List<ExpinData>> findAllExpinDatas() async {
    final expins = await _dao.findAllExpins();
    final expinDatas = await expins.map(_getExpinData).toFuture;
    return expinDatas.removeNulls;
  }

  @override
  Stream<List<ExpinData>> watchAllExpinDatas() {
    return Rx.combineLatest3(
      _dao.watchAllExpins(),
      _categoryDao.watchAllCategories(),
      _paymentDao.watchAllPayments(),
      (expins, categories, payments) => expins.map(
        (expin) {
          if (expin.isTransfer) {
            final from = payments.findItem((i) => i.id == expin.paymentId);
            if (from == null) return null;
            final to = payments.findItem((i) => i.id == expin.toPaymentId);
            if (to == null) return null;
            return _buildExpinDataTransfer(expin, from, to);
          } else {
            final category =
                categories.findItem((i) => i.id == expin.categoryId);
            if (category == null) return null;
            final payment = payments.findItem((i) => i.id == expin.paymentId);
            if (payment == null) return null;
            return _buildExpinDataExpin(expin, category, payment);
          }
        },
      ).removeNulls,
    );
  }
}
