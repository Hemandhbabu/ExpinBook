// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_All _$$_AllFromJson(Map<String, dynamic> json) => _$_All(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_AllToJson(_$_All instance) => <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_Payment _$$_PaymentFromJson(Map<String, dynamic> json) => _$_Payment(
      Payment.fromJson(json['payment'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_PaymentToJson(_$_Payment instance) =>
    <String, dynamic>{
      'payment': instance.payment,
      'runtimeType': instance.$type,
    };

_$_Payments _$$_PaymentsFromJson(Map<String, dynamic> json) => _$_Payments(
      (json['payments'] as List<dynamic>)
          .map((e) => Payment.fromJson(e as String))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_PaymentsToJson(_$_Payments instance) =>
    <String, dynamic>{
      'payments': instance.payments,
      'runtimeType': instance.$type,
    };
