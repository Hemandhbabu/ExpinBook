// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'loan_transaction_list_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoanTransactionListData {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime dateTime, int count) date,
    required TResult Function(LoanTransaction transaction) data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime dateTime, int count)? date,
    TResult? Function(LoanTransaction transaction)? data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime dateTime, int count)? date,
    TResult Function(LoanTransaction transaction)? data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Date value) date,
    required TResult Function(_Data value) data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Date value)? date,
    TResult? Function(_Data value)? data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Date value)? date,
    TResult Function(_Data value)? data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoanTransactionListDataCopyWith<$Res> {
  factory $LoanTransactionListDataCopyWith(LoanTransactionListData value,
          $Res Function(LoanTransactionListData) then) =
      _$LoanTransactionListDataCopyWithImpl<$Res, LoanTransactionListData>;
}

/// @nodoc
class _$LoanTransactionListDataCopyWithImpl<$Res,
        $Val extends LoanTransactionListData>
    implements $LoanTransactionListDataCopyWith<$Res> {
  _$LoanTransactionListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_DateCopyWith<$Res> {
  factory _$$_DateCopyWith(_$_Date value, $Res Function(_$_Date) then) =
      __$$_DateCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime dateTime, int count});
}

/// @nodoc
class __$$_DateCopyWithImpl<$Res>
    extends _$LoanTransactionListDataCopyWithImpl<$Res, _$_Date>
    implements _$$_DateCopyWith<$Res> {
  __$$_DateCopyWithImpl(_$_Date _value, $Res Function(_$_Date) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = null,
    Object? count = null,
  }) {
    return _then(_$_Date(
      null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Date implements _Date {
  const _$_Date(this.dateTime, this.count);

  @override
  final DateTime dateTime;
  @override
  final int count;

  @override
  String toString() {
    return 'LoanTransactionListData.date(dateTime: $dateTime, count: $count)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Date &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.count, count) || other.count == count));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dateTime, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DateCopyWith<_$_Date> get copyWith =>
      __$$_DateCopyWithImpl<_$_Date>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime dateTime, int count) date,
    required TResult Function(LoanTransaction transaction) data,
  }) {
    return date(dateTime, count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime dateTime, int count)? date,
    TResult? Function(LoanTransaction transaction)? data,
  }) {
    return date?.call(dateTime, count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime dateTime, int count)? date,
    TResult Function(LoanTransaction transaction)? data,
    required TResult orElse(),
  }) {
    if (date != null) {
      return date(dateTime, count);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Date value) date,
    required TResult Function(_Data value) data,
  }) {
    return date(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Date value)? date,
    TResult? Function(_Data value)? data,
  }) {
    return date?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Date value)? date,
    TResult Function(_Data value)? data,
    required TResult orElse(),
  }) {
    if (date != null) {
      return date(this);
    }
    return orElse();
  }
}

abstract class _Date implements LoanTransactionListData {
  const factory _Date(final DateTime dateTime, final int count) = _$_Date;

  DateTime get dateTime;
  int get count;
  @JsonKey(ignore: true)
  _$$_DateCopyWith<_$_Date> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_DataCopyWith<$Res> {
  factory _$$_DataCopyWith(_$_Data value, $Res Function(_$_Data) then) =
      __$$_DataCopyWithImpl<$Res>;
  @useResult
  $Res call({LoanTransaction transaction});
}

/// @nodoc
class __$$_DataCopyWithImpl<$Res>
    extends _$LoanTransactionListDataCopyWithImpl<$Res, _$_Data>
    implements _$$_DataCopyWith<$Res> {
  __$$_DataCopyWithImpl(_$_Data _value, $Res Function(_$_Data) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
  }) {
    return _then(_$_Data(
      null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as LoanTransaction,
    ));
  }
}

/// @nodoc

class _$_Data implements _Data {
  const _$_Data(this.transaction);

  @override
  final LoanTransaction transaction;

  @override
  String toString() {
    return 'LoanTransactionListData.data(transaction: $transaction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Data &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DataCopyWith<_$_Data> get copyWith =>
      __$$_DataCopyWithImpl<_$_Data>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime dateTime, int count) date,
    required TResult Function(LoanTransaction transaction) data,
  }) {
    return data(transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime dateTime, int count)? date,
    TResult? Function(LoanTransaction transaction)? data,
  }) {
    return data?.call(transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime dateTime, int count)? date,
    TResult Function(LoanTransaction transaction)? data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(transaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Date value) date,
    required TResult Function(_Data value) data,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Date value)? date,
    TResult? Function(_Data value)? data,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Date value)? date,
    TResult Function(_Data value)? data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _Data implements LoanTransactionListData {
  const factory _Data(final LoanTransaction transaction) = _$_Data;

  LoanTransaction get transaction;
  @JsonKey(ignore: true)
  _$$_DataCopyWith<_$_Data> get copyWith => throw _privateConstructorUsedError;
}
