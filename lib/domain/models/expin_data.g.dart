// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expin_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExpinD _$$_ExpinDFromJson(Map<String, dynamic> json) => _$_ExpinD(
      IncomeExpense.fromJson(json['incomeExpense'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_ExpinDToJson(_$_ExpinD instance) => <String, dynamic>{
      'incomeExpense': instance.incomeExpense,
      'runtimeType': instance.$type,
    };

_$_TransferD _$$_TransferDFromJson(Map<String, dynamic> json) => _$_TransferD(
      Transfer.fromJson(json['transfer'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_TransferDToJson(_$_TransferD instance) =>
    <String, dynamic>{
      'transfer': instance.transfer,
      'runtimeType': instance.$type,
    };

_$_IncomeExpense _$$_IncomeExpenseFromJson(Map<String, dynamic> json) =>
    _$_IncomeExpense(
      id: json['id'] as int,
      amount: (json['amount'] as num).toDouble(),
      isIncome: json['isIncome'] as bool,
      categoryId: json['categoryId'] as int,
      paymentId: json['paymentId'] as int,
      description: json['description'] as String?,
      imagePath: json['imagePath'] as String?,
      dateTime: DateTime.parse(json['dateTime'] as String),
      categoryName: json['categoryName'] as String,
      categoryIconIndex: json['categoryIconIndex'] as int?,
      categorySymbol: json['categorySymbol'] as String?,
      categoryColor:
          const ColorConverter().fromJson(json['categoryColor'] as int),
      paymentName: json['paymentName'] as String,
      paymentMode: $enumDecode(_$PaymentModeEnumMap, json['paymentMode']),
      paymentColor:
          const ColorConverter().fromJson(json['paymentColor'] as int),
    );

Map<String, dynamic> _$$_IncomeExpenseToJson(_$_IncomeExpense instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'isIncome': instance.isIncome,
      'categoryId': instance.categoryId,
      'paymentId': instance.paymentId,
      'description': instance.description,
      'imagePath': instance.imagePath,
      'dateTime': instance.dateTime.toIso8601String(),
      'categoryName': instance.categoryName,
      'categoryIconIndex': instance.categoryIconIndex,
      'categorySymbol': instance.categorySymbol,
      'categoryColor': const ColorConverter().toJson(instance.categoryColor),
      'paymentName': instance.paymentName,
      'paymentMode': _$PaymentModeEnumMap[instance.paymentMode]!,
      'paymentColor': const ColorConverter().toJson(instance.paymentColor),
    };

const _$PaymentModeEnumMap = {
  PaymentMode.cash: 'cash',
  PaymentMode.card: 'card',
  PaymentMode.cheque: 'cheque',
  PaymentMode.netBanking: 'netBanking',
  PaymentMode.wallet: 'wallet',
  PaymentMode.upi: 'upi',
};

_$_Transfer _$$_TransferFromJson(Map<String, dynamic> json) => _$_Transfer(
      id: json['id'] as int,
      amount: (json['amount'] as num).toDouble(),
      fromPaymentId: json['fromPaymentId'] as int,
      toPaymentId: json['toPaymentId'] as int,
      description: json['description'] as String?,
      imagePath: json['imagePath'] as String?,
      dateTime: DateTime.parse(json['dateTime'] as String),
      fromPaymentName: json['fromPaymentName'] as String,
      fromPaymentMode:
          $enumDecode(_$PaymentModeEnumMap, json['fromPaymentMode']),
      fromPaymentColor:
          const ColorConverter().fromJson(json['fromPaymentColor'] as int),
      toPaymentName: json['toPaymentName'] as String,
      toPaymentMode: $enumDecode(_$PaymentModeEnumMap, json['toPaymentMode']),
      toPaymentColor:
          const ColorConverter().fromJson(json['toPaymentColor'] as int),
    );

Map<String, dynamic> _$$_TransferToJson(_$_Transfer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'fromPaymentId': instance.fromPaymentId,
      'toPaymentId': instance.toPaymentId,
      'description': instance.description,
      'imagePath': instance.imagePath,
      'dateTime': instance.dateTime.toIso8601String(),
      'fromPaymentName': instance.fromPaymentName,
      'fromPaymentMode': _$PaymentModeEnumMap[instance.fromPaymentMode]!,
      'fromPaymentColor':
          const ColorConverter().toJson(instance.fromPaymentColor),
      'toPaymentName': instance.toPaymentName,
      'toPaymentMode': _$PaymentModeEnumMap[instance.toPaymentMode]!,
      'toPaymentColor': const ColorConverter().toJson(instance.toPaymentColor),
    };
