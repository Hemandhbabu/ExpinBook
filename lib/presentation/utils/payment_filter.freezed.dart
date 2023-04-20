// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'payment_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaymentFilter _$PaymentFilterFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'all':
      return _All.fromJson(json);
    case 'payment':
      return _Payment.fromJson(json);
    case 'payments':
      return _Payments.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'PaymentFilter',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$PaymentFilter {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function(Payment payment) payment,
    required TResult Function(List<Payment> payments) payments,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function(Payment payment)? payment,
    TResult? Function(List<Payment> payments)? payments,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function(Payment payment)? payment,
    TResult Function(List<Payment> payments)? payments,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_All value) all,
    required TResult Function(_Payment value) payment,
    required TResult Function(_Payments value) payments,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Payment value)? payment,
    TResult? Function(_Payments value)? payments,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Payment value)? payment,
    TResult Function(_Payments value)? payments,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentFilterCopyWith<$Res> {
  factory $PaymentFilterCopyWith(
          PaymentFilter value, $Res Function(PaymentFilter) then) =
      _$PaymentFilterCopyWithImpl<$Res, PaymentFilter>;
}

/// @nodoc
class _$PaymentFilterCopyWithImpl<$Res, $Val extends PaymentFilter>
    implements $PaymentFilterCopyWith<$Res> {
  _$PaymentFilterCopyWithImpl(this._value, this._then);

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
class __$$_AllCopyWithImpl<$Res>
    extends _$PaymentFilterCopyWithImpl<$Res, _$_All>
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
    return 'PaymentFilter.all()';
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
    required TResult Function(Payment payment) payment,
    required TResult Function(List<Payment> payments) payments,
  }) {
    return all();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function(Payment payment)? payment,
    TResult? Function(List<Payment> payments)? payments,
  }) {
    return all?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function(Payment payment)? payment,
    TResult Function(List<Payment> payments)? payments,
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
    required TResult Function(_Payment value) payment,
    required TResult Function(_Payments value) payments,
  }) {
    return all(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Payment value)? payment,
    TResult? Function(_Payments value)? payments,
  }) {
    return all?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Payment value)? payment,
    TResult Function(_Payments value)? payments,
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

abstract class _All extends PaymentFilter {
  const factory _All() = _$_All;
  const _All._() : super._();

  factory _All.fromJson(Map<String, dynamic> json) = _$_All.fromJson;
}

/// @nodoc
abstract class _$$_PaymentCopyWith<$Res> {
  factory _$$_PaymentCopyWith(
          _$_Payment value, $Res Function(_$_Payment) then) =
      __$$_PaymentCopyWithImpl<$Res>;
  @useResult
  $Res call({Payment payment});
}

/// @nodoc
class __$$_PaymentCopyWithImpl<$Res>
    extends _$PaymentFilterCopyWithImpl<$Res, _$_Payment>
    implements _$$_PaymentCopyWith<$Res> {
  __$$_PaymentCopyWithImpl(_$_Payment _value, $Res Function(_$_Payment) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payment = null,
  }) {
    return _then(_$_Payment(
      null == payment
          ? _value.payment
          : payment // ignore: cast_nullable_to_non_nullable
              as Payment,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Payment extends _Payment {
  const _$_Payment(this.payment, {final String? $type})
      : $type = $type ?? 'payment',
        super._();

  factory _$_Payment.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentFromJson(json);

  @override
  final Payment payment;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PaymentFilter.payment(payment: $payment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Payment &&
            (identical(other.payment, payment) || other.payment == payment));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, payment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaymentCopyWith<_$_Payment> get copyWith =>
      __$$_PaymentCopyWithImpl<_$_Payment>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function(Payment payment) payment,
    required TResult Function(List<Payment> payments) payments,
  }) {
    return payment(this.payment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function(Payment payment)? payment,
    TResult? Function(List<Payment> payments)? payments,
  }) {
    return payment?.call(this.payment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function(Payment payment)? payment,
    TResult Function(List<Payment> payments)? payments,
    required TResult orElse(),
  }) {
    if (payment != null) {
      return payment(this.payment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_All value) all,
    required TResult Function(_Payment value) payment,
    required TResult Function(_Payments value) payments,
  }) {
    return payment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Payment value)? payment,
    TResult? Function(_Payments value)? payments,
  }) {
    return payment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Payment value)? payment,
    TResult Function(_Payments value)? payments,
    required TResult orElse(),
  }) {
    if (payment != null) {
      return payment(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentToJson(
      this,
    );
  }
}

abstract class _Payment extends PaymentFilter {
  const factory _Payment(final Payment payment) = _$_Payment;
  const _Payment._() : super._();

  factory _Payment.fromJson(Map<String, dynamic> json) = _$_Payment.fromJson;

  Payment get payment;
  @JsonKey(ignore: true)
  _$$_PaymentCopyWith<_$_Payment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_PaymentsCopyWith<$Res> {
  factory _$$_PaymentsCopyWith(
          _$_Payments value, $Res Function(_$_Payments) then) =
      __$$_PaymentsCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Payment> payments});
}

/// @nodoc
class __$$_PaymentsCopyWithImpl<$Res>
    extends _$PaymentFilterCopyWithImpl<$Res, _$_Payments>
    implements _$$_PaymentsCopyWith<$Res> {
  __$$_PaymentsCopyWithImpl(
      _$_Payments _value, $Res Function(_$_Payments) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payments = null,
  }) {
    return _then(_$_Payments(
      null == payments
          ? _value._payments
          : payments // ignore: cast_nullable_to_non_nullable
              as List<Payment>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Payments extends _Payments {
  const _$_Payments(final List<Payment> payments, {final String? $type})
      : _payments = payments,
        $type = $type ?? 'payments',
        super._();

  factory _$_Payments.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentsFromJson(json);

  final List<Payment> _payments;
  @override
  List<Payment> get payments {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_payments);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PaymentFilter.payments(payments: $payments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Payments &&
            const DeepCollectionEquality().equals(other._payments, _payments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_payments));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaymentsCopyWith<_$_Payments> get copyWith =>
      __$$_PaymentsCopyWithImpl<_$_Payments>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function(Payment payment) payment,
    required TResult Function(List<Payment> payments) payments,
  }) {
    return payments(this.payments);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function(Payment payment)? payment,
    TResult? Function(List<Payment> payments)? payments,
  }) {
    return payments?.call(this.payments);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function(Payment payment)? payment,
    TResult Function(List<Payment> payments)? payments,
    required TResult orElse(),
  }) {
    if (payments != null) {
      return payments(this.payments);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_All value) all,
    required TResult Function(_Payment value) payment,
    required TResult Function(_Payments value) payments,
  }) {
    return payments(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Payment value)? payment,
    TResult? Function(_Payments value)? payments,
  }) {
    return payments?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Payment value)? payment,
    TResult Function(_Payments value)? payments,
    required TResult orElse(),
  }) {
    if (payments != null) {
      return payments(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentsToJson(
      this,
    );
  }
}

abstract class _Payments extends PaymentFilter {
  const factory _Payments(final List<Payment> payments) = _$_Payments;
  const _Payments._() : super._();

  factory _Payments.fromJson(Map<String, dynamic> json) = _$_Payments.fromJson;

  List<Payment> get payments;
  @JsonKey(ignore: true)
  _$$_PaymentsCopyWith<_$_Payments> get copyWith =>
      throw _privateConstructorUsedError;
}
