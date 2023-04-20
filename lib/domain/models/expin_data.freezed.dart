// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'expin_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExpinData _$ExpinDataFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'expin':
      return _ExpinD.fromJson(json);
    case 'transfer':
      return _TransferD.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ExpinData',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ExpinData {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(IncomeExpense incomeExpense) expin,
    required TResult Function(Transfer transfer) transfer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(IncomeExpense incomeExpense)? expin,
    TResult? Function(Transfer transfer)? transfer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(IncomeExpense incomeExpense)? expin,
    TResult Function(Transfer transfer)? transfer,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ExpinD value) expin,
    required TResult Function(_TransferD value) transfer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ExpinD value)? expin,
    TResult? Function(_TransferD value)? transfer,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ExpinD value)? expin,
    TResult Function(_TransferD value)? transfer,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpinDataCopyWith<$Res> {
  factory $ExpinDataCopyWith(ExpinData value, $Res Function(ExpinData) then) =
      _$ExpinDataCopyWithImpl<$Res, ExpinData>;
}

/// @nodoc
class _$ExpinDataCopyWithImpl<$Res, $Val extends ExpinData>
    implements $ExpinDataCopyWith<$Res> {
  _$ExpinDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_ExpinDCopyWith<$Res> {
  factory _$$_ExpinDCopyWith(_$_ExpinD value, $Res Function(_$_ExpinD) then) =
      __$$_ExpinDCopyWithImpl<$Res>;
  @useResult
  $Res call({IncomeExpense incomeExpense});

  $IncomeExpenseCopyWith<$Res> get incomeExpense;
}

/// @nodoc
class __$$_ExpinDCopyWithImpl<$Res>
    extends _$ExpinDataCopyWithImpl<$Res, _$_ExpinD>
    implements _$$_ExpinDCopyWith<$Res> {
  __$$_ExpinDCopyWithImpl(_$_ExpinD _value, $Res Function(_$_ExpinD) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? incomeExpense = null,
  }) {
    return _then(_$_ExpinD(
      null == incomeExpense
          ? _value.incomeExpense
          : incomeExpense // ignore: cast_nullable_to_non_nullable
              as IncomeExpense,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $IncomeExpenseCopyWith<$Res> get incomeExpense {
    return $IncomeExpenseCopyWith<$Res>(_value.incomeExpense, (value) {
      return _then(_value.copyWith(incomeExpense: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExpinD extends _ExpinD {
  const _$_ExpinD(this.incomeExpense, {final String? $type})
      : $type = $type ?? 'expin',
        super._();

  factory _$_ExpinD.fromJson(Map<String, dynamic> json) =>
      _$$_ExpinDFromJson(json);

  @override
  final IncomeExpense incomeExpense;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ExpinData.expin(incomeExpense: $incomeExpense)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExpinD &&
            (identical(other.incomeExpense, incomeExpense) ||
                other.incomeExpense == incomeExpense));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, incomeExpense);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExpinDCopyWith<_$_ExpinD> get copyWith =>
      __$$_ExpinDCopyWithImpl<_$_ExpinD>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(IncomeExpense incomeExpense) expin,
    required TResult Function(Transfer transfer) transfer,
  }) {
    return expin(incomeExpense);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(IncomeExpense incomeExpense)? expin,
    TResult? Function(Transfer transfer)? transfer,
  }) {
    return expin?.call(incomeExpense);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(IncomeExpense incomeExpense)? expin,
    TResult Function(Transfer transfer)? transfer,
    required TResult orElse(),
  }) {
    if (expin != null) {
      return expin(incomeExpense);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ExpinD value) expin,
    required TResult Function(_TransferD value) transfer,
  }) {
    return expin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ExpinD value)? expin,
    TResult? Function(_TransferD value)? transfer,
  }) {
    return expin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ExpinD value)? expin,
    TResult Function(_TransferD value)? transfer,
    required TResult orElse(),
  }) {
    if (expin != null) {
      return expin(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExpinDToJson(
      this,
    );
  }
}

abstract class _ExpinD extends ExpinData {
  const factory _ExpinD(final IncomeExpense incomeExpense) = _$_ExpinD;
  const _ExpinD._() : super._();

  factory _ExpinD.fromJson(Map<String, dynamic> json) = _$_ExpinD.fromJson;

  IncomeExpense get incomeExpense;
  @JsonKey(ignore: true)
  _$$_ExpinDCopyWith<_$_ExpinD> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_TransferDCopyWith<$Res> {
  factory _$$_TransferDCopyWith(
          _$_TransferD value, $Res Function(_$_TransferD) then) =
      __$$_TransferDCopyWithImpl<$Res>;
  @useResult
  $Res call({Transfer transfer});

  $TransferCopyWith<$Res> get transfer;
}

/// @nodoc
class __$$_TransferDCopyWithImpl<$Res>
    extends _$ExpinDataCopyWithImpl<$Res, _$_TransferD>
    implements _$$_TransferDCopyWith<$Res> {
  __$$_TransferDCopyWithImpl(
      _$_TransferD _value, $Res Function(_$_TransferD) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transfer = null,
  }) {
    return _then(_$_TransferD(
      null == transfer
          ? _value.transfer
          : transfer // ignore: cast_nullable_to_non_nullable
              as Transfer,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $TransferCopyWith<$Res> get transfer {
    return $TransferCopyWith<$Res>(_value.transfer, (value) {
      return _then(_value.copyWith(transfer: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$_TransferD extends _TransferD {
  const _$_TransferD(this.transfer, {final String? $type})
      : $type = $type ?? 'transfer',
        super._();

  factory _$_TransferD.fromJson(Map<String, dynamic> json) =>
      _$$_TransferDFromJson(json);

  @override
  final Transfer transfer;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ExpinData.transfer(transfer: $transfer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransferD &&
            (identical(other.transfer, transfer) ||
                other.transfer == transfer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, transfer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransferDCopyWith<_$_TransferD> get copyWith =>
      __$$_TransferDCopyWithImpl<_$_TransferD>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(IncomeExpense incomeExpense) expin,
    required TResult Function(Transfer transfer) transfer,
  }) {
    return transfer(this.transfer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(IncomeExpense incomeExpense)? expin,
    TResult? Function(Transfer transfer)? transfer,
  }) {
    return transfer?.call(this.transfer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(IncomeExpense incomeExpense)? expin,
    TResult Function(Transfer transfer)? transfer,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(this.transfer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ExpinD value) expin,
    required TResult Function(_TransferD value) transfer,
  }) {
    return transfer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ExpinD value)? expin,
    TResult? Function(_TransferD value)? transfer,
  }) {
    return transfer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ExpinD value)? expin,
    TResult Function(_TransferD value)? transfer,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransferDToJson(
      this,
    );
  }
}

abstract class _TransferD extends ExpinData {
  const factory _TransferD(final Transfer transfer) = _$_TransferD;
  const _TransferD._() : super._();

  factory _TransferD.fromJson(Map<String, dynamic> json) =
      _$_TransferD.fromJson;

  Transfer get transfer;
  @JsonKey(ignore: true)
  _$$_TransferDCopyWith<_$_TransferD> get copyWith =>
      throw _privateConstructorUsedError;
}

IncomeExpense _$IncomeExpenseFromJson(Map<String, dynamic> json) {
  return _IncomeExpense.fromJson(json);
}

/// @nodoc
mixin _$IncomeExpense {
  int get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  bool get isIncome => throw _privateConstructorUsedError;
  int get categoryId => throw _privateConstructorUsedError;
  int get paymentId => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  String get categoryName => throw _privateConstructorUsedError;
  int? get categoryIconIndex => throw _privateConstructorUsedError;
  String? get categorySymbol => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get categoryColor => throw _privateConstructorUsedError;
  String get paymentName => throw _privateConstructorUsedError;
  PaymentMode get paymentMode => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get paymentColor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IncomeExpenseCopyWith<IncomeExpense> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncomeExpenseCopyWith<$Res> {
  factory $IncomeExpenseCopyWith(
          IncomeExpense value, $Res Function(IncomeExpense) then) =
      _$IncomeExpenseCopyWithImpl<$Res, IncomeExpense>;
  @useResult
  $Res call(
      {int id,
      double amount,
      bool isIncome,
      int categoryId,
      int paymentId,
      String? description,
      String? imagePath,
      DateTime dateTime,
      String categoryName,
      int? categoryIconIndex,
      String? categorySymbol,
      @ColorConverter() Color categoryColor,
      String paymentName,
      PaymentMode paymentMode,
      @ColorConverter() Color paymentColor});
}

/// @nodoc
class _$IncomeExpenseCopyWithImpl<$Res, $Val extends IncomeExpense>
    implements $IncomeExpenseCopyWith<$Res> {
  _$IncomeExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? isIncome = null,
    Object? categoryId = null,
    Object? paymentId = null,
    Object? description = freezed,
    Object? imagePath = freezed,
    Object? dateTime = null,
    Object? categoryName = null,
    Object? categoryIconIndex = freezed,
    Object? categorySymbol = freezed,
    Object? categoryColor = null,
    Object? paymentName = null,
    Object? paymentMode = null,
    Object? paymentColor = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      isIncome: null == isIncome
          ? _value.isIncome
          : isIncome // ignore: cast_nullable_to_non_nullable
              as bool,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryIconIndex: freezed == categoryIconIndex
          ? _value.categoryIconIndex
          : categoryIconIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      categorySymbol: freezed == categorySymbol
          ? _value.categorySymbol
          : categorySymbol // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryColor: null == categoryColor
          ? _value.categoryColor
          : categoryColor // ignore: cast_nullable_to_non_nullable
              as Color,
      paymentName: null == paymentName
          ? _value.paymentName
          : paymentName // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMode: null == paymentMode
          ? _value.paymentMode
          : paymentMode // ignore: cast_nullable_to_non_nullable
              as PaymentMode,
      paymentColor: null == paymentColor
          ? _value.paymentColor
          : paymentColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_IncomeExpenseCopyWith<$Res>
    implements $IncomeExpenseCopyWith<$Res> {
  factory _$$_IncomeExpenseCopyWith(
          _$_IncomeExpense value, $Res Function(_$_IncomeExpense) then) =
      __$$_IncomeExpenseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      double amount,
      bool isIncome,
      int categoryId,
      int paymentId,
      String? description,
      String? imagePath,
      DateTime dateTime,
      String categoryName,
      int? categoryIconIndex,
      String? categorySymbol,
      @ColorConverter() Color categoryColor,
      String paymentName,
      PaymentMode paymentMode,
      @ColorConverter() Color paymentColor});
}

/// @nodoc
class __$$_IncomeExpenseCopyWithImpl<$Res>
    extends _$IncomeExpenseCopyWithImpl<$Res, _$_IncomeExpense>
    implements _$$_IncomeExpenseCopyWith<$Res> {
  __$$_IncomeExpenseCopyWithImpl(
      _$_IncomeExpense _value, $Res Function(_$_IncomeExpense) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? isIncome = null,
    Object? categoryId = null,
    Object? paymentId = null,
    Object? description = freezed,
    Object? imagePath = freezed,
    Object? dateTime = null,
    Object? categoryName = null,
    Object? categoryIconIndex = freezed,
    Object? categorySymbol = freezed,
    Object? categoryColor = null,
    Object? paymentName = null,
    Object? paymentMode = null,
    Object? paymentColor = null,
  }) {
    return _then(_$_IncomeExpense(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      isIncome: null == isIncome
          ? _value.isIncome
          : isIncome // ignore: cast_nullable_to_non_nullable
              as bool,
      categoryId: null == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as int,
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      categoryIconIndex: freezed == categoryIconIndex
          ? _value.categoryIconIndex
          : categoryIconIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      categorySymbol: freezed == categorySymbol
          ? _value.categorySymbol
          : categorySymbol // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryColor: null == categoryColor
          ? _value.categoryColor
          : categoryColor // ignore: cast_nullable_to_non_nullable
              as Color,
      paymentName: null == paymentName
          ? _value.paymentName
          : paymentName // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMode: null == paymentMode
          ? _value.paymentMode
          : paymentMode // ignore: cast_nullable_to_non_nullable
              as PaymentMode,
      paymentColor: null == paymentColor
          ? _value.paymentColor
          : paymentColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_IncomeExpense extends _IncomeExpense {
  const _$_IncomeExpense(
      {required this.id,
      required this.amount,
      required this.isIncome,
      required this.categoryId,
      required this.paymentId,
      required this.description,
      required this.imagePath,
      required this.dateTime,
      required this.categoryName,
      required this.categoryIconIndex,
      required this.categorySymbol,
      @ColorConverter() required this.categoryColor,
      required this.paymentName,
      required this.paymentMode,
      @ColorConverter() required this.paymentColor})
      : super._();

  factory _$_IncomeExpense.fromJson(Map<String, dynamic> json) =>
      _$$_IncomeExpenseFromJson(json);

  @override
  final int id;
  @override
  final double amount;
  @override
  final bool isIncome;
  @override
  final int categoryId;
  @override
  final int paymentId;
  @override
  final String? description;
  @override
  final String? imagePath;
  @override
  final DateTime dateTime;
  @override
  final String categoryName;
  @override
  final int? categoryIconIndex;
  @override
  final String? categorySymbol;
  @override
  @ColorConverter()
  final Color categoryColor;
  @override
  final String paymentName;
  @override
  final PaymentMode paymentMode;
  @override
  @ColorConverter()
  final Color paymentColor;

  @override
  String toString() {
    return 'IncomeExpense(id: $id, amount: $amount, isIncome: $isIncome, categoryId: $categoryId, paymentId: $paymentId, description: $description, imagePath: $imagePath, dateTime: $dateTime, categoryName: $categoryName, categoryIconIndex: $categoryIconIndex, categorySymbol: $categorySymbol, categoryColor: $categoryColor, paymentName: $paymentName, paymentMode: $paymentMode, paymentColor: $paymentColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IncomeExpense &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.isIncome, isIncome) ||
                other.isIncome == isIncome) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categoryIconIndex, categoryIconIndex) ||
                other.categoryIconIndex == categoryIconIndex) &&
            (identical(other.categorySymbol, categorySymbol) ||
                other.categorySymbol == categorySymbol) &&
            (identical(other.categoryColor, categoryColor) ||
                other.categoryColor == categoryColor) &&
            (identical(other.paymentName, paymentName) ||
                other.paymentName == paymentName) &&
            (identical(other.paymentMode, paymentMode) ||
                other.paymentMode == paymentMode) &&
            (identical(other.paymentColor, paymentColor) ||
                other.paymentColor == paymentColor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      amount,
      isIncome,
      categoryId,
      paymentId,
      description,
      imagePath,
      dateTime,
      categoryName,
      categoryIconIndex,
      categorySymbol,
      categoryColor,
      paymentName,
      paymentMode,
      paymentColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IncomeExpenseCopyWith<_$_IncomeExpense> get copyWith =>
      __$$_IncomeExpenseCopyWithImpl<_$_IncomeExpense>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IncomeExpenseToJson(
      this,
    );
  }
}

abstract class _IncomeExpense extends IncomeExpense {
  const factory _IncomeExpense(
      {required final int id,
      required final double amount,
      required final bool isIncome,
      required final int categoryId,
      required final int paymentId,
      required final String? description,
      required final String? imagePath,
      required final DateTime dateTime,
      required final String categoryName,
      required final int? categoryIconIndex,
      required final String? categorySymbol,
      @ColorConverter() required final Color categoryColor,
      required final String paymentName,
      required final PaymentMode paymentMode,
      @ColorConverter() required final Color paymentColor}) = _$_IncomeExpense;
  const _IncomeExpense._() : super._();

  factory _IncomeExpense.fromJson(Map<String, dynamic> json) =
      _$_IncomeExpense.fromJson;

  @override
  int get id;
  @override
  double get amount;
  @override
  bool get isIncome;
  @override
  int get categoryId;
  @override
  int get paymentId;
  @override
  String? get description;
  @override
  String? get imagePath;
  @override
  DateTime get dateTime;
  @override
  String get categoryName;
  @override
  int? get categoryIconIndex;
  @override
  String? get categorySymbol;
  @override
  @ColorConverter()
  Color get categoryColor;
  @override
  String get paymentName;
  @override
  PaymentMode get paymentMode;
  @override
  @ColorConverter()
  Color get paymentColor;
  @override
  @JsonKey(ignore: true)
  _$$_IncomeExpenseCopyWith<_$_IncomeExpense> get copyWith =>
      throw _privateConstructorUsedError;
}

Transfer _$TransferFromJson(Map<String, dynamic> json) {
  return _Transfer.fromJson(json);
}

/// @nodoc
mixin _$Transfer {
  int get id => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  int get fromPaymentId => throw _privateConstructorUsedError;
  int get toPaymentId => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imagePath => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  String get fromPaymentName => throw _privateConstructorUsedError;
  PaymentMode get fromPaymentMode => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get fromPaymentColor => throw _privateConstructorUsedError;
  String get toPaymentName => throw _privateConstructorUsedError;
  PaymentMode get toPaymentMode => throw _privateConstructorUsedError;
  @ColorConverter()
  Color get toPaymentColor => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransferCopyWith<Transfer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferCopyWith<$Res> {
  factory $TransferCopyWith(Transfer value, $Res Function(Transfer) then) =
      _$TransferCopyWithImpl<$Res, Transfer>;
  @useResult
  $Res call(
      {int id,
      double amount,
      int fromPaymentId,
      int toPaymentId,
      String? description,
      String? imagePath,
      DateTime dateTime,
      String fromPaymentName,
      PaymentMode fromPaymentMode,
      @ColorConverter() Color fromPaymentColor,
      String toPaymentName,
      PaymentMode toPaymentMode,
      @ColorConverter() Color toPaymentColor});
}

/// @nodoc
class _$TransferCopyWithImpl<$Res, $Val extends Transfer>
    implements $TransferCopyWith<$Res> {
  _$TransferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? fromPaymentId = null,
    Object? toPaymentId = null,
    Object? description = freezed,
    Object? imagePath = freezed,
    Object? dateTime = null,
    Object? fromPaymentName = null,
    Object? fromPaymentMode = null,
    Object? fromPaymentColor = null,
    Object? toPaymentName = null,
    Object? toPaymentMode = null,
    Object? toPaymentColor = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      fromPaymentId: null == fromPaymentId
          ? _value.fromPaymentId
          : fromPaymentId // ignore: cast_nullable_to_non_nullable
              as int,
      toPaymentId: null == toPaymentId
          ? _value.toPaymentId
          : toPaymentId // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fromPaymentName: null == fromPaymentName
          ? _value.fromPaymentName
          : fromPaymentName // ignore: cast_nullable_to_non_nullable
              as String,
      fromPaymentMode: null == fromPaymentMode
          ? _value.fromPaymentMode
          : fromPaymentMode // ignore: cast_nullable_to_non_nullable
              as PaymentMode,
      fromPaymentColor: null == fromPaymentColor
          ? _value.fromPaymentColor
          : fromPaymentColor // ignore: cast_nullable_to_non_nullable
              as Color,
      toPaymentName: null == toPaymentName
          ? _value.toPaymentName
          : toPaymentName // ignore: cast_nullable_to_non_nullable
              as String,
      toPaymentMode: null == toPaymentMode
          ? _value.toPaymentMode
          : toPaymentMode // ignore: cast_nullable_to_non_nullable
              as PaymentMode,
      toPaymentColor: null == toPaymentColor
          ? _value.toPaymentColor
          : toPaymentColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransferCopyWith<$Res> implements $TransferCopyWith<$Res> {
  factory _$$_TransferCopyWith(
          _$_Transfer value, $Res Function(_$_Transfer) then) =
      __$$_TransferCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      double amount,
      int fromPaymentId,
      int toPaymentId,
      String? description,
      String? imagePath,
      DateTime dateTime,
      String fromPaymentName,
      PaymentMode fromPaymentMode,
      @ColorConverter() Color fromPaymentColor,
      String toPaymentName,
      PaymentMode toPaymentMode,
      @ColorConverter() Color toPaymentColor});
}

/// @nodoc
class __$$_TransferCopyWithImpl<$Res>
    extends _$TransferCopyWithImpl<$Res, _$_Transfer>
    implements _$$_TransferCopyWith<$Res> {
  __$$_TransferCopyWithImpl(
      _$_Transfer _value, $Res Function(_$_Transfer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? fromPaymentId = null,
    Object? toPaymentId = null,
    Object? description = freezed,
    Object? imagePath = freezed,
    Object? dateTime = null,
    Object? fromPaymentName = null,
    Object? fromPaymentMode = null,
    Object? fromPaymentColor = null,
    Object? toPaymentName = null,
    Object? toPaymentMode = null,
    Object? toPaymentColor = null,
  }) {
    return _then(_$_Transfer(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      fromPaymentId: null == fromPaymentId
          ? _value.fromPaymentId
          : fromPaymentId // ignore: cast_nullable_to_non_nullable
              as int,
      toPaymentId: null == toPaymentId
          ? _value.toPaymentId
          : toPaymentId // ignore: cast_nullable_to_non_nullable
              as int,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imagePath: freezed == imagePath
          ? _value.imagePath
          : imagePath // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fromPaymentName: null == fromPaymentName
          ? _value.fromPaymentName
          : fromPaymentName // ignore: cast_nullable_to_non_nullable
              as String,
      fromPaymentMode: null == fromPaymentMode
          ? _value.fromPaymentMode
          : fromPaymentMode // ignore: cast_nullable_to_non_nullable
              as PaymentMode,
      fromPaymentColor: null == fromPaymentColor
          ? _value.fromPaymentColor
          : fromPaymentColor // ignore: cast_nullable_to_non_nullable
              as Color,
      toPaymentName: null == toPaymentName
          ? _value.toPaymentName
          : toPaymentName // ignore: cast_nullable_to_non_nullable
              as String,
      toPaymentMode: null == toPaymentMode
          ? _value.toPaymentMode
          : toPaymentMode // ignore: cast_nullable_to_non_nullable
              as PaymentMode,
      toPaymentColor: null == toPaymentColor
          ? _value.toPaymentColor
          : toPaymentColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Transfer implements _Transfer {
  const _$_Transfer(
      {required this.id,
      required this.amount,
      required this.fromPaymentId,
      required this.toPaymentId,
      required this.description,
      required this.imagePath,
      required this.dateTime,
      required this.fromPaymentName,
      required this.fromPaymentMode,
      @ColorConverter() required this.fromPaymentColor,
      required this.toPaymentName,
      required this.toPaymentMode,
      @ColorConverter() required this.toPaymentColor});

  factory _$_Transfer.fromJson(Map<String, dynamic> json) =>
      _$$_TransferFromJson(json);

  @override
  final int id;
  @override
  final double amount;
  @override
  final int fromPaymentId;
  @override
  final int toPaymentId;
  @override
  final String? description;
  @override
  final String? imagePath;
  @override
  final DateTime dateTime;
  @override
  final String fromPaymentName;
  @override
  final PaymentMode fromPaymentMode;
  @override
  @ColorConverter()
  final Color fromPaymentColor;
  @override
  final String toPaymentName;
  @override
  final PaymentMode toPaymentMode;
  @override
  @ColorConverter()
  final Color toPaymentColor;

  @override
  String toString() {
    return 'Transfer(id: $id, amount: $amount, fromPaymentId: $fromPaymentId, toPaymentId: $toPaymentId, description: $description, imagePath: $imagePath, dateTime: $dateTime, fromPaymentName: $fromPaymentName, fromPaymentMode: $fromPaymentMode, fromPaymentColor: $fromPaymentColor, toPaymentName: $toPaymentName, toPaymentMode: $toPaymentMode, toPaymentColor: $toPaymentColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Transfer &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.fromPaymentId, fromPaymentId) ||
                other.fromPaymentId == fromPaymentId) &&
            (identical(other.toPaymentId, toPaymentId) ||
                other.toPaymentId == toPaymentId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.fromPaymentName, fromPaymentName) ||
                other.fromPaymentName == fromPaymentName) &&
            (identical(other.fromPaymentMode, fromPaymentMode) ||
                other.fromPaymentMode == fromPaymentMode) &&
            (identical(other.fromPaymentColor, fromPaymentColor) ||
                other.fromPaymentColor == fromPaymentColor) &&
            (identical(other.toPaymentName, toPaymentName) ||
                other.toPaymentName == toPaymentName) &&
            (identical(other.toPaymentMode, toPaymentMode) ||
                other.toPaymentMode == toPaymentMode) &&
            (identical(other.toPaymentColor, toPaymentColor) ||
                other.toPaymentColor == toPaymentColor));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      amount,
      fromPaymentId,
      toPaymentId,
      description,
      imagePath,
      dateTime,
      fromPaymentName,
      fromPaymentMode,
      fromPaymentColor,
      toPaymentName,
      toPaymentMode,
      toPaymentColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransferCopyWith<_$_Transfer> get copyWith =>
      __$$_TransferCopyWithImpl<_$_Transfer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransferToJson(
      this,
    );
  }
}

abstract class _Transfer implements Transfer {
  const factory _Transfer(
      {required final int id,
      required final double amount,
      required final int fromPaymentId,
      required final int toPaymentId,
      required final String? description,
      required final String? imagePath,
      required final DateTime dateTime,
      required final String fromPaymentName,
      required final PaymentMode fromPaymentMode,
      @ColorConverter() required final Color fromPaymentColor,
      required final String toPaymentName,
      required final PaymentMode toPaymentMode,
      @ColorConverter() required final Color toPaymentColor}) = _$_Transfer;

  factory _Transfer.fromJson(Map<String, dynamic> json) = _$_Transfer.fromJson;

  @override
  int get id;
  @override
  double get amount;
  @override
  int get fromPaymentId;
  @override
  int get toPaymentId;
  @override
  String? get description;
  @override
  String? get imagePath;
  @override
  DateTime get dateTime;
  @override
  String get fromPaymentName;
  @override
  PaymentMode get fromPaymentMode;
  @override
  @ColorConverter()
  Color get fromPaymentColor;
  @override
  String get toPaymentName;
  @override
  PaymentMode get toPaymentMode;
  @override
  @ColorConverter()
  Color get toPaymentColor;
  @override
  @JsonKey(ignore: true)
  _$$_TransferCopyWith<_$_Transfer> get copyWith =>
      throw _privateConstructorUsedError;
}
