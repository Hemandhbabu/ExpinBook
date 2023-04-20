// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'type_filter_list_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TypeFilterListData<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isIncome) title,
    required TResult Function(T value) value,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isIncome)? title,
    TResult? Function(T value)? value,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isIncome)? title,
    TResult Function(T value)? value,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Title<T> value) title,
    required TResult Function(_Value<T> value) value,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Title<T> value)? title,
    TResult? Function(_Value<T> value)? value,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Title<T> value)? title,
    TResult Function(_Value<T> value)? value,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TypeFilterListDataCopyWith<T, $Res> {
  factory $TypeFilterListDataCopyWith(TypeFilterListData<T> value,
          $Res Function(TypeFilterListData<T>) then) =
      _$TypeFilterListDataCopyWithImpl<T, $Res, TypeFilterListData<T>>;
}

/// @nodoc
class _$TypeFilterListDataCopyWithImpl<T, $Res,
        $Val extends TypeFilterListData<T>>
    implements $TypeFilterListDataCopyWith<T, $Res> {
  _$TypeFilterListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_TitleCopyWith<T, $Res> {
  factory _$$_TitleCopyWith(
          _$_Title<T> value, $Res Function(_$_Title<T>) then) =
      __$$_TitleCopyWithImpl<T, $Res>;
  @useResult
  $Res call({bool isIncome});
}

/// @nodoc
class __$$_TitleCopyWithImpl<T, $Res>
    extends _$TypeFilterListDataCopyWithImpl<T, $Res, _$_Title<T>>
    implements _$$_TitleCopyWith<T, $Res> {
  __$$_TitleCopyWithImpl(_$_Title<T> _value, $Res Function(_$_Title<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isIncome = null,
  }) {
    return _then(_$_Title<T>(
      null == isIncome
          ? _value.isIncome
          : isIncome // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_Title<T> implements _Title<T> {
  const _$_Title(this.isIncome);

  @override
  final bool isIncome;

  @override
  String toString() {
    return 'TypeFilterListData<$T>.title(isIncome: $isIncome)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Title<T> &&
            (identical(other.isIncome, isIncome) ||
                other.isIncome == isIncome));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isIncome);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TitleCopyWith<T, _$_Title<T>> get copyWith =>
      __$$_TitleCopyWithImpl<T, _$_Title<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isIncome) title,
    required TResult Function(T value) value,
  }) {
    return title(isIncome);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isIncome)? title,
    TResult? Function(T value)? value,
  }) {
    return title?.call(isIncome);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isIncome)? title,
    TResult Function(T value)? value,
    required TResult orElse(),
  }) {
    if (title != null) {
      return title(isIncome);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Title<T> value) title,
    required TResult Function(_Value<T> value) value,
  }) {
    return title(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Title<T> value)? title,
    TResult? Function(_Value<T> value)? value,
  }) {
    return title?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Title<T> value)? title,
    TResult Function(_Value<T> value)? value,
    required TResult orElse(),
  }) {
    if (title != null) {
      return title(this);
    }
    return orElse();
  }
}

abstract class _Title<T> implements TypeFilterListData<T> {
  const factory _Title(final bool isIncome) = _$_Title<T>;

  bool get isIncome;
  @JsonKey(ignore: true)
  _$$_TitleCopyWith<T, _$_Title<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_ValueCopyWith<T, $Res> {
  factory _$$_ValueCopyWith(
          _$_Value<T> value, $Res Function(_$_Value<T>) then) =
      __$$_ValueCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T value});
}

/// @nodoc
class __$$_ValueCopyWithImpl<T, $Res>
    extends _$TypeFilterListDataCopyWithImpl<T, $Res, _$_Value<T>>
    implements _$$_ValueCopyWith<T, $Res> {
  __$$_ValueCopyWithImpl(_$_Value<T> _value, $Res Function(_$_Value<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$_Value<T>(
      null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_Value<T> implements _Value<T> {
  const _$_Value(this.value);

  @override
  final T value;

  @override
  String toString() {
    return 'TypeFilterListData<$T>.value(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Value<T> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ValueCopyWith<T, _$_Value<T>> get copyWith =>
      __$$_ValueCopyWithImpl<T, _$_Value<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isIncome) title,
    required TResult Function(T value) value,
  }) {
    return value(this.value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isIncome)? title,
    TResult? Function(T value)? value,
  }) {
    return value?.call(this.value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isIncome)? title,
    TResult Function(T value)? value,
    required TResult orElse(),
  }) {
    if (value != null) {
      return value(this.value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Title<T> value) title,
    required TResult Function(_Value<T> value) value,
  }) {
    return value(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Title<T> value)? title,
    TResult? Function(_Value<T> value)? value,
  }) {
    return value?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Title<T> value)? title,
    TResult Function(_Value<T> value)? value,
    required TResult orElse(),
  }) {
    if (value != null) {
      return value(this);
    }
    return orElse();
  }
}

abstract class _Value<T> implements TypeFilterListData<T> {
  const factory _Value(final T value) = _$_Value<T>;

  T get value;
  @JsonKey(ignore: true)
  _$$_ValueCopyWith<T, _$_Value<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
