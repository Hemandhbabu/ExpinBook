// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_All _$$_AllFromJson(Map<String, dynamic> json) => _$_All(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_AllToJson(_$_All instance) => <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_Date _$$_DateFromJson(Map<String, dynamic> json) => _$_Date(
      DateTime.parse(json['dateTime'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_DateToJson(_$_Date instance) => <String, dynamic>{
      'dateTime': instance.dateTime.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$_Month _$$_MonthFromJson(Map<String, dynamic> json) => _$_Month(
      DateTime.parse(json['dateTime'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_MonthToJson(_$_Month instance) => <String, dynamic>{
      'dateTime': instance.dateTime.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$_Year _$$_YearFromJson(Map<String, dynamic> json) => _$_Year(
      DateTime.parse(json['dateTime'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_YearToJson(_$_Year instance) => <String, dynamic>{
      'dateTime': instance.dateTime.toIso8601String(),
      'runtimeType': instance.$type,
    };

_$_DateTimeRange _$$_DateTimeRangeFromJson(Map<String, dynamic> json) =>
    _$_DateTimeRange(
      const DateTimeRangeJsonConverter().fromJson(json['range'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_DateTimeRangeToJson(_$_DateTimeRange instance) =>
    <String, dynamic>{
      'range': const DateTimeRangeJsonConverter().toJson(instance.range),
      'runtimeType': instance.$type,
    };
