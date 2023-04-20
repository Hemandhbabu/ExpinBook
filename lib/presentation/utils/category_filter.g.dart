// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_All _$$_AllFromJson(Map<String, dynamic> json) => _$_All(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_AllToJson(_$_All instance) => <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_Income _$$_IncomeFromJson(Map<String, dynamic> json) => _$_Income(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_IncomeToJson(_$_Income instance) => <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_Expense _$$_ExpenseFromJson(Map<String, dynamic> json) => _$_Expense(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_ExpenseToJson(_$_Expense instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_Transfer _$$_TransferFromJson(Map<String, dynamic> json) => _$_Transfer(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_TransferToJson(_$_Transfer instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$_Category _$$_CategoryFromJson(Map<String, dynamic> json) => _$_Category(
      Category.fromJson(json['category'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_CategoryToJson(_$_Category instance) =>
    <String, dynamic>{
      'category': instance.category,
      'runtimeType': instance.$type,
    };

_$_Categories _$$_CategoriesFromJson(Map<String, dynamic> json) =>
    _$_Categories(
      (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as String))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_CategoriesToJson(_$_Categories instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'runtimeType': instance.$type,
    };
