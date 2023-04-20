// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'date_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DateFilter _$DateFilterFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'all':
      return _All.fromJson(json);
    case 'date':
      return _Date.fromJson(json);
    case 'month':
      return _Month.fromJson(json);
    case 'year':
      return _Year.fromJson(json);
    case 'dateTimeRange':
      return _DateTimeRange.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'DateFilter',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$DateFilter {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function(DateTime dateTime) date,
    required TResult Function(DateTime dateTime) month,
    required TResult Function(DateTime dateTime) year,
    required TResult Function(@DateTimeRangeJsonConverter() DateTimeRange range)
        dateTimeRange,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function(DateTime dateTime)? date,
    TResult? Function(DateTime dateTime)? month,
    TResult? Function(DateTime dateTime)? year,
    TResult? Function(@DateTimeRangeJsonConverter() DateTimeRange range)?
        dateTimeRange,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function(DateTime dateTime)? date,
    TResult Function(DateTime dateTime)? month,
    TResult Function(DateTime dateTime)? year,
    TResult Function(@DateTimeRangeJsonConverter() DateTimeRange range)?
        dateTimeRange,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_All value) all,
    required TResult Function(_Date value) date,
    required TResult Function(_Month value) month,
    required TResult Function(_Year value) year,
    required TResult Function(_DateTimeRange value) dateTimeRange,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Date value)? date,
    TResult? Function(_Month value)? month,
    TResult? Function(_Year value)? year,
    TResult? Function(_DateTimeRange value)? dateTimeRange,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Date value)? date,
    TResult Function(_Month value)? month,
    TResult Function(_Year value)? year,
    TResult Function(_DateTimeRange value)? dateTimeRange,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateFilterCopyWith<$Res> {
  factory $DateFilterCopyWith(
          DateFilter value, $Res Function(DateFilter) then) =
      _$DateFilterCopyWithImpl<$Res, DateFilter>;
}

/// @nodoc
class _$DateFilterCopyWithImpl<$Res, $Val extends DateFilter>
    implements $DateFilterCopyWith<$Res> {
  _$DateFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_AllCopyWith<$Res> {
  factory _$$_AllCopyWith(_$_All value, $Res Function(_$_All) then) =
      __$$_AllCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_AllCopyWithImpl<$Res> extends _$DateFilterCopyWithImpl<$Res, _$_All>
    implements _$$_AllCopyWith<$Res> {
  __$$_AllCopyWithImpl(_$_All _value, $Res Function(_$_All) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$_All extends _All {
  const _$_All({final String? $type})
      : $type = $type ?? 'all',
        super._();

  factory _$_All.fromJson(Map<String, dynamic> json) => _$$_AllFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DateFilter.all()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_All);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function(DateTime dateTime) date,
    required TResult Function(DateTime dateTime) month,
    required TResult Function(DateTime dateTime) year,
    required TResult Function(@DateTimeRangeJsonConverter() DateTimeRange range)
        dateTimeRange,
  }) {
    return all();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function(DateTime dateTime)? date,
    TResult? Function(DateTime dateTime)? month,
    TResult? Function(DateTime dateTime)? year,
    TResult? Function(@DateTimeRangeJsonConverter() DateTimeRange range)?
        dateTimeRange,
  }) {
    return all?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function(DateTime dateTime)? date,
    TResult Function(DateTime dateTime)? month,
    TResult Function(DateTime dateTime)? year,
    TResult Function(@DateTimeRangeJsonConverter() DateTimeRange range)?
        dateTimeRange,
    required TResult orElse(),
  }) {
    if (all != null) {
      return all();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_All value) all,
    required TResult Function(_Date value) date,
    required TResult Function(_Month value) month,
    required TResult Function(_Year value) year,
    required TResult Function(_DateTimeRange value) dateTimeRange,
  }) {
    return all(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Date value)? date,
    TResult? Function(_Month value)? month,
    TResult? Function(_Year value)? year,
    TResult? Function(_DateTimeRange value)? dateTimeRange,
  }) {
    return all?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Date value)? date,
    TResult Function(_Month value)? month,
    TResult Function(_Year value)? year,
    TResult Function(_DateTimeRange value)? dateTimeRange,
    required TResult orElse(),
  }) {
    if (all != null) {
      return all(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_AllToJson(
      this,
    );
  }
}

abstract class _All extends DateFilter {
  const factory _All() = _$_All;
  const _All._() : super._();

  factory _All.fromJson(Map<String, dynamic> json) = _$_All.fromJson;
}

/// @nodoc
abstract class _$$_DateCopyWith<$Res> {
  factory _$$_DateCopyWith(_$_Date value, $Res Function(_$_Date) then) =
      __$$_DateCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime dateTime});
}

/// @nodoc
class __$$_DateCopyWithImpl<$Res>
    extends _$DateFilterCopyWithImpl<$Res, _$_Date>
    implements _$$_DateCopyWith<$Res> {
  __$$_DateCopyWithImpl(_$_Date _value, $Res Function(_$_Date) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = null,
  }) {
    return _then(_$_Date(
      null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Date extends _Date {
  const _$_Date(this.dateTime, {final String? $type})
      : $type = $type ?? 'date',
        super._();

  factory _$_Date.fromJson(Map<String, dynamic> json) => _$$_DateFromJson(json);

  @override
  final DateTime dateTime;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DateFilter.date(dateTime: $dateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Date &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, dateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DateCopyWith<_$_Date> get copyWith =>
      __$$_DateCopyWithImpl<_$_Date>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function(DateTime dateTime) date,
    required TResult Function(DateTime dateTime) month,
    required TResult Function(DateTime dateTime) year,
    required TResult Function(@DateTimeRangeJsonConverter() DateTimeRange range)
        dateTimeRange,
  }) {
    return date(dateTime);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function(DateTime dateTime)? date,
    TResult? Function(DateTime dateTime)? month,
    TResult? Function(DateTime dateTime)? year,
    TResult? Function(@DateTimeRangeJsonConverter() DateTimeRange range)?
        dateTimeRange,
  }) {
    return date?.call(dateTime);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function(DateTime dateTime)? date,
    TResult Function(DateTime dateTime)? month,
    TResult Function(DateTime dateTime)? year,
    TResult Function(@DateTimeRangeJsonConverter() DateTimeRange range)?
        dateTimeRange,
    required TResult orElse(),
  }) {
    if (date != null) {
      return date(dateTime);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_All value) all,
    required TResult Function(_Date value) date,
    required TResult Function(_Month value) month,
    required TResult Function(_Year value) year,
    required TResult Function(_DateTimeRange value) dateTimeRange,
  }) {
    return date(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Date value)? date,
    TResult? Function(_Month value)? month,
    TResult? Function(_Year value)? year,
    TResult? Function(_DateTimeRange value)? dateTimeRange,
  }) {
    return date?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Date value)? date,
    TResult Function(_Month value)? month,
    TResult Function(_Year value)? year,
    TResult Function(_DateTimeRange value)? dateTimeRange,
    required TResult orElse(),
  }) {
    if (date != null) {
      return date(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_DateToJson(
      this,
    );
  }
}

abstract class _Date extends DateFilter {
  const factory _Date(final DateTime dateTime) = _$_Date;
  const _Date._() : super._();

  factory _Date.fromJson(Map<String, dynamic> json) = _$_Date.fromJson;

  DateTime get dateTime;
  @JsonKey(ignore: true)
  _$$_DateCopyWith<_$_Date> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_MonthCopyWith<$Res> {
  factory _$$_MonthCopyWith(_$_Month value, $Res Function(_$_Month) then) =
      __$$_MonthCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime dateTime});
}

/// @nodoc
class __$$_MonthCopyWithImpl<$Res>
    extends _$DateFilterCopyWithImpl<$Res, _$_Month>
    implements _$$_MonthCopyWith<$Res> {
  __$$_MonthCopyWithImpl(_$_Month _value, $Res Function(_$_Month) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = null,
  }) {
    return _then(_$_Month(
      null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Month extends _Month {
  const _$_Month(this.dateTime, {final String? $type})
      : $type = $type ?? 'month',
        super._();

  factory _$_Month.fromJson(Map<String, dynamic> json) =>
      _$$_MonthFromJson(json);

  @override
  final DateTime dateTime;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DateFilter.month(dateTime: $dateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Month &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, dateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MonthCopyWith<_$_Month> get copyWith =>
      __$$_MonthCopyWithImpl<_$_Month>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function(DateTime dateTime) date,
    required TResult Function(DateTime dateTime) month,
    required TResult Function(DateTime dateTime) year,
    required TResult Function(@DateTimeRangeJsonConverter() DateTimeRange range)
        dateTimeRange,
  }) {
    return month(dateTime);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function(DateTime dateTime)? date,
    TResult? Function(DateTime dateTime)? month,
    TResult? Function(DateTime dateTime)? year,
    TResult? Function(@DateTimeRangeJsonConverter() DateTimeRange range)?
        dateTimeRange,
  }) {
    return month?.call(dateTime);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function(DateTime dateTime)? date,
    TResult Function(DateTime dateTime)? month,
    TResult Function(DateTime dateTime)? year,
    TResult Function(@DateTimeRangeJsonConverter() DateTimeRange range)?
        dateTimeRange,
    required TResult orElse(),
  }) {
    if (month != null) {
      return month(dateTime);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_All value) all,
    required TResult Function(_Date value) date,
    required TResult Function(_Month value) month,
    required TResult Function(_Year value) year,
    required TResult Function(_DateTimeRange value) dateTimeRange,
  }) {
    return month(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Date value)? date,
    TResult? Function(_Month value)? month,
    TResult? Function(_Year value)? year,
    TResult? Function(_DateTimeRange value)? dateTimeRange,
  }) {
    return month?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Date value)? date,
    TResult Function(_Month value)? month,
    TResult Function(_Year value)? year,
    TResult Function(_DateTimeRange value)? dateTimeRange,
    required TResult orElse(),
  }) {
    if (month != null) {
      return month(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_MonthToJson(
      this,
    );
  }
}

abstract class _Month extends DateFilter {
  const factory _Month(final DateTime dateTime) = _$_Month;
  const _Month._() : super._();

  factory _Month.fromJson(Map<String, dynamic> json) = _$_Month.fromJson;

  DateTime get dateTime;
  @JsonKey(ignore: true)
  _$$_MonthCopyWith<_$_Month> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_YearCopyWith<$Res> {
  factory _$$_YearCopyWith(_$_Year value, $Res Function(_$_Year) then) =
      __$$_YearCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime dateTime});
}

/// @nodoc
class __$$_YearCopyWithImpl<$Res>
    extends _$DateFilterCopyWithImpl<$Res, _$_Year>
    implements _$$_YearCopyWith<$Res> {
  __$$_YearCopyWithImpl(_$_Year _value, $Res Function(_$_Year) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateTime = null,
  }) {
    return _then(_$_Year(
      null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Year extends _Year {
  const _$_Year(this.dateTime, {final String? $type})
      : $type = $type ?? 'year',
        super._();

  factory _$_Year.fromJson(Map<String, dynamic> json) => _$$_YearFromJson(json);

  @override
  final DateTime dateTime;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DateFilter.year(dateTime: $dateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Year &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, dateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_YearCopyWith<_$_Year> get copyWith =>
      __$$_YearCopyWithImpl<_$_Year>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function(DateTime dateTime) date,
    required TResult Function(DateTime dateTime) month,
    required TResult Function(DateTime dateTime) year,
    required TResult Function(@DateTimeRangeJsonConverter() DateTimeRange range)
        dateTimeRange,
  }) {
    return year(dateTime);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function(DateTime dateTime)? date,
    TResult? Function(DateTime dateTime)? month,
    TResult? Function(DateTime dateTime)? year,
    TResult? Function(@DateTimeRangeJsonConverter() DateTimeRange range)?
        dateTimeRange,
  }) {
    return year?.call(dateTime);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function(DateTime dateTime)? date,
    TResult Function(DateTime dateTime)? month,
    TResult Function(DateTime dateTime)? year,
    TResult Function(@DateTimeRangeJsonConverter() DateTimeRange range)?
        dateTimeRange,
    required TResult orElse(),
  }) {
    if (year != null) {
      return year(dateTime);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_All value) all,
    required TResult Function(_Date value) date,
    required TResult Function(_Month value) month,
    required TResult Function(_Year value) year,
    required TResult Function(_DateTimeRange value) dateTimeRange,
  }) {
    return year(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Date value)? date,
    TResult? Function(_Month value)? month,
    TResult? Function(_Year value)? year,
    TResult? Function(_DateTimeRange value)? dateTimeRange,
  }) {
    return year?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Date value)? date,
    TResult Function(_Month value)? month,
    TResult Function(_Year value)? year,
    TResult Function(_DateTimeRange value)? dateTimeRange,
    required TResult orElse(),
  }) {
    if (year != null) {
      return year(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_YearToJson(
      this,
    );
  }
}

abstract class _Year extends DateFilter {
  const factory _Year(final DateTime dateTime) = _$_Year;
  const _Year._() : super._();

  factory _Year.fromJson(Map<String, dynamic> json) = _$_Year.fromJson;

  DateTime get dateTime;
  @JsonKey(ignore: true)
  _$$_YearCopyWith<_$_Year> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_DateTimeRangeCopyWith<$Res> {
  factory _$$_DateTimeRangeCopyWith(
          _$_DateTimeRange value, $Res Function(_$_DateTimeRange) then) =
      __$$_DateTimeRangeCopyWithImpl<$Res>;
  @useResult
  $Res call({@DateTimeRangeJsonConverter() DateTimeRange range});
}

/// @nodoc
class __$$_DateTimeRangeCopyWithImpl<$Res>
    extends _$DateFilterCopyWithImpl<$Res, _$_DateTimeRange>
    implements _$$_DateTimeRangeCopyWith<$Res> {
  __$$_DateTimeRangeCopyWithImpl(
      _$_DateTimeRange _value, $Res Function(_$_DateTimeRange) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? range = null,
  }) {
    return _then(_$_DateTimeRange(
      null == range
          ? _value.range
          : range // ignore: cast_nullable_to_non_nullable
              as DateTimeRange,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DateTimeRange extends _DateTimeRange {
  const _$_DateTimeRange(@DateTimeRangeJsonConverter() this.range,
      {final String? $type})
      : $type = $type ?? 'dateTimeRange',
        super._();

  factory _$_DateTimeRange.fromJson(Map<String, dynamic> json) =>
      _$$_DateTimeRangeFromJson(json);

  @override
  @DateTimeRangeJsonConverter()
  final DateTimeRange range;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'DateFilter.dateTimeRange(range: $range)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DateTimeRange &&
            (identical(other.range, range) || other.range == range));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, range);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DateTimeRangeCopyWith<_$_DateTimeRange> get copyWith =>
      __$$_DateTimeRangeCopyWithImpl<_$_DateTimeRange>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function(DateTime dateTime) date,
    required TResult Function(DateTime dateTime) month,
    required TResult Function(DateTime dateTime) year,
    required TResult Function(@DateTimeRangeJsonConverter() DateTimeRange range)
        dateTimeRange,
  }) {
    return dateTimeRange(range);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function(DateTime dateTime)? date,
    TResult? Function(DateTime dateTime)? month,
    TResult? Function(DateTime dateTime)? year,
    TResult? Function(@DateTimeRangeJsonConverter() DateTimeRange range)?
        dateTimeRange,
  }) {
    return dateTimeRange?.call(range);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function(DateTime dateTime)? date,
    TResult Function(DateTime dateTime)? month,
    TResult Function(DateTime dateTime)? year,
    TResult Function(@DateTimeRangeJsonConverter() DateTimeRange range)?
        dateTimeRange,
    required TResult orElse(),
  }) {
    if (dateTimeRange != null) {
      return dateTimeRange(range);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_All value) all,
    required TResult Function(_Date value) date,
    required TResult Function(_Month value) month,
    required TResult Function(_Year value) year,
    required TResult Function(_DateTimeRange value) dateTimeRange,
  }) {
    return dateTimeRange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Date value)? date,
    TResult? Function(_Month value)? month,
    TResult? Function(_Year value)? year,
    TResult? Function(_DateTimeRange value)? dateTimeRange,
  }) {
    return dateTimeRange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Date value)? date,
    TResult Function(_Month value)? month,
    TResult Function(_Year value)? year,
    TResult Function(_DateTimeRange value)? dateTimeRange,
    required TResult orElse(),
  }) {
    if (dateTimeRange != null) {
      return dateTimeRange(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_DateTimeRangeToJson(
      this,
    );
  }
}

abstract class _DateTimeRange extends DateFilter {
  const factory _DateTimeRange(
          @DateTimeRangeJsonConverter() final DateTimeRange range) =
      _$_DateTimeRange;
  const _DateTimeRange._() : super._();

  factory _DateTimeRange.fromJson(Map<String, dynamic> json) =
      _$_DateTimeRange.fromJson;

  @DateTimeRangeJsonConverter()
  DateTimeRange get range;
  @JsonKey(ignore: true)
  _$$_DateTimeRangeCopyWith<_$_DateTimeRange> get copyWith =>
      throw _privateConstructorUsedError;
}
