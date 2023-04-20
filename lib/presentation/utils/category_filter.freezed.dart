// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'category_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CategoryFilter _$CategoryFilterFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'all':
      return _All.fromJson(json);
    case 'income':
      return _Income.fromJson(json);
    case 'expense':
      return _Expense.fromJson(json);
    case 'transfer':
      return _Transfer.fromJson(json);
    case 'category':
      return _Category.fromJson(json);
    case 'categories':
      return _Categories.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'CategoryFilter',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$CategoryFilter {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function() income,
    required TResult Function() expense,
    required TResult Function() transfer,
    required TResult Function(Category category) category,
    required TResult Function(List<Category> categories) categories,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function()? income,
    TResult? Function()? expense,
    TResult? Function()? transfer,
    TResult? Function(Category category)? category,
    TResult? Function(List<Category> categories)? categories,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function()? income,
    TResult Function()? expense,
    TResult Function()? transfer,
    TResult Function(Category category)? category,
    TResult Function(List<Category> categories)? categories,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_All value) all,
    required TResult Function(_Income value) income,
    required TResult Function(_Expense value) expense,
    required TResult Function(_Transfer value) transfer,
    required TResult Function(_Category value) category,
    required TResult Function(_Categories value) categories,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Income value)? income,
    TResult? Function(_Expense value)? expense,
    TResult? Function(_Transfer value)? transfer,
    TResult? Function(_Category value)? category,
    TResult? Function(_Categories value)? categories,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Income value)? income,
    TResult Function(_Expense value)? expense,
    TResult Function(_Transfer value)? transfer,
    TResult Function(_Category value)? category,
    TResult Function(_Categories value)? categories,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryFilterCopyWith<$Res> {
  factory $CategoryFilterCopyWith(
          CategoryFilter value, $Res Function(CategoryFilter) then) =
      _$CategoryFilterCopyWithImpl<$Res, CategoryFilter>;
}

/// @nodoc
class _$CategoryFilterCopyWithImpl<$Res, $Val extends CategoryFilter>
    implements $CategoryFilterCopyWith<$Res> {
  _$CategoryFilterCopyWithImpl(this._value, this._then);

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
    extends _$CategoryFilterCopyWithImpl<$Res, _$_All>
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
    return 'CategoryFilter.all()';
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
    required TResult Function() income,
    required TResult Function() expense,
    required TResult Function() transfer,
    required TResult Function(Category category) category,
    required TResult Function(List<Category> categories) categories,
  }) {
    return all();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function()? income,
    TResult? Function()? expense,
    TResult? Function()? transfer,
    TResult? Function(Category category)? category,
    TResult? Function(List<Category> categories)? categories,
  }) {
    return all?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function()? income,
    TResult Function()? expense,
    TResult Function()? transfer,
    TResult Function(Category category)? category,
    TResult Function(List<Category> categories)? categories,
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
    required TResult Function(_Income value) income,
    required TResult Function(_Expense value) expense,
    required TResult Function(_Transfer value) transfer,
    required TResult Function(_Category value) category,
    required TResult Function(_Categories value) categories,
  }) {
    return all(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Income value)? income,
    TResult? Function(_Expense value)? expense,
    TResult? Function(_Transfer value)? transfer,
    TResult? Function(_Category value)? category,
    TResult? Function(_Categories value)? categories,
  }) {
    return all?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Income value)? income,
    TResult Function(_Expense value)? expense,
    TResult Function(_Transfer value)? transfer,
    TResult Function(_Category value)? category,
    TResult Function(_Categories value)? categories,
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

abstract class _All extends CategoryFilter {
  const factory _All() = _$_All;
  const _All._() : super._();

  factory _All.fromJson(Map<String, dynamic> json) = _$_All.fromJson;
}

/// @nodoc
abstract class _$$_IncomeCopyWith<$Res> {
  factory _$$_IncomeCopyWith(_$_Income value, $Res Function(_$_Income) then) =
      __$$_IncomeCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_IncomeCopyWithImpl<$Res>
    extends _$CategoryFilterCopyWithImpl<$Res, _$_Income>
    implements _$$_IncomeCopyWith<$Res> {
  __$$_IncomeCopyWithImpl(_$_Income _value, $Res Function(_$_Income) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$_Income extends _Income {
  const _$_Income({final String? $type})
      : $type = $type ?? 'income',
        super._();

  factory _$_Income.fromJson(Map<String, dynamic> json) =>
      _$$_IncomeFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CategoryFilter.income()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Income);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function() income,
    required TResult Function() expense,
    required TResult Function() transfer,
    required TResult Function(Category category) category,
    required TResult Function(List<Category> categories) categories,
  }) {
    return income();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function()? income,
    TResult? Function()? expense,
    TResult? Function()? transfer,
    TResult? Function(Category category)? category,
    TResult? Function(List<Category> categories)? categories,
  }) {
    return income?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function()? income,
    TResult Function()? expense,
    TResult Function()? transfer,
    TResult Function(Category category)? category,
    TResult Function(List<Category> categories)? categories,
    required TResult orElse(),
  }) {
    if (income != null) {
      return income();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_All value) all,
    required TResult Function(_Income value) income,
    required TResult Function(_Expense value) expense,
    required TResult Function(_Transfer value) transfer,
    required TResult Function(_Category value) category,
    required TResult Function(_Categories value) categories,
  }) {
    return income(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Income value)? income,
    TResult? Function(_Expense value)? expense,
    TResult? Function(_Transfer value)? transfer,
    TResult? Function(_Category value)? category,
    TResult? Function(_Categories value)? categories,
  }) {
    return income?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Income value)? income,
    TResult Function(_Expense value)? expense,
    TResult Function(_Transfer value)? transfer,
    TResult Function(_Category value)? category,
    TResult Function(_Categories value)? categories,
    required TResult orElse(),
  }) {
    if (income != null) {
      return income(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_IncomeToJson(
      this,
    );
  }
}

abstract class _Income extends CategoryFilter {
  const factory _Income() = _$_Income;
  const _Income._() : super._();

  factory _Income.fromJson(Map<String, dynamic> json) = _$_Income.fromJson;
}

/// @nodoc
abstract class _$$_ExpenseCopyWith<$Res> {
  factory _$$_ExpenseCopyWith(
          _$_Expense value, $Res Function(_$_Expense) then) =
      __$$_ExpenseCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_ExpenseCopyWithImpl<$Res>
    extends _$CategoryFilterCopyWithImpl<$Res, _$_Expense>
    implements _$$_ExpenseCopyWith<$Res> {
  __$$_ExpenseCopyWithImpl(_$_Expense _value, $Res Function(_$_Expense) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$_Expense extends _Expense {
  const _$_Expense({final String? $type})
      : $type = $type ?? 'expense',
        super._();

  factory _$_Expense.fromJson(Map<String, dynamic> json) =>
      _$$_ExpenseFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CategoryFilter.expense()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Expense);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function() income,
    required TResult Function() expense,
    required TResult Function() transfer,
    required TResult Function(Category category) category,
    required TResult Function(List<Category> categories) categories,
  }) {
    return expense();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function()? income,
    TResult? Function()? expense,
    TResult? Function()? transfer,
    TResult? Function(Category category)? category,
    TResult? Function(List<Category> categories)? categories,
  }) {
    return expense?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function()? income,
    TResult Function()? expense,
    TResult Function()? transfer,
    TResult Function(Category category)? category,
    TResult Function(List<Category> categories)? categories,
    required TResult orElse(),
  }) {
    if (expense != null) {
      return expense();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_All value) all,
    required TResult Function(_Income value) income,
    required TResult Function(_Expense value) expense,
    required TResult Function(_Transfer value) transfer,
    required TResult Function(_Category value) category,
    required TResult Function(_Categories value) categories,
  }) {
    return expense(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Income value)? income,
    TResult? Function(_Expense value)? expense,
    TResult? Function(_Transfer value)? transfer,
    TResult? Function(_Category value)? category,
    TResult? Function(_Categories value)? categories,
  }) {
    return expense?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Income value)? income,
    TResult Function(_Expense value)? expense,
    TResult Function(_Transfer value)? transfer,
    TResult Function(_Category value)? category,
    TResult Function(_Categories value)? categories,
    required TResult orElse(),
  }) {
    if (expense != null) {
      return expense(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExpenseToJson(
      this,
    );
  }
}

abstract class _Expense extends CategoryFilter {
  const factory _Expense() = _$_Expense;
  const _Expense._() : super._();

  factory _Expense.fromJson(Map<String, dynamic> json) = _$_Expense.fromJson;
}

/// @nodoc
abstract class _$$_TransferCopyWith<$Res> {
  factory _$$_TransferCopyWith(
          _$_Transfer value, $Res Function(_$_Transfer) then) =
      __$$_TransferCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_TransferCopyWithImpl<$Res>
    extends _$CategoryFilterCopyWithImpl<$Res, _$_Transfer>
    implements _$$_TransferCopyWith<$Res> {
  __$$_TransferCopyWithImpl(
      _$_Transfer _value, $Res Function(_$_Transfer) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$_Transfer extends _Transfer {
  const _$_Transfer({final String? $type})
      : $type = $type ?? 'transfer',
        super._();

  factory _$_Transfer.fromJson(Map<String, dynamic> json) =>
      _$$_TransferFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CategoryFilter.transfer()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Transfer);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function() income,
    required TResult Function() expense,
    required TResult Function() transfer,
    required TResult Function(Category category) category,
    required TResult Function(List<Category> categories) categories,
  }) {
    return transfer();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function()? income,
    TResult? Function()? expense,
    TResult? Function()? transfer,
    TResult? Function(Category category)? category,
    TResult? Function(List<Category> categories)? categories,
  }) {
    return transfer?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function()? income,
    TResult Function()? expense,
    TResult Function()? transfer,
    TResult Function(Category category)? category,
    TResult Function(List<Category> categories)? categories,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_All value) all,
    required TResult Function(_Income value) income,
    required TResult Function(_Expense value) expense,
    required TResult Function(_Transfer value) transfer,
    required TResult Function(_Category value) category,
    required TResult Function(_Categories value) categories,
  }) {
    return transfer(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Income value)? income,
    TResult? Function(_Expense value)? expense,
    TResult? Function(_Transfer value)? transfer,
    TResult? Function(_Category value)? category,
    TResult? Function(_Categories value)? categories,
  }) {
    return transfer?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Income value)? income,
    TResult Function(_Expense value)? expense,
    TResult Function(_Transfer value)? transfer,
    TResult Function(_Category value)? category,
    TResult Function(_Categories value)? categories,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_TransferToJson(
      this,
    );
  }
}

abstract class _Transfer extends CategoryFilter {
  const factory _Transfer() = _$_Transfer;
  const _Transfer._() : super._();

  factory _Transfer.fromJson(Map<String, dynamic> json) = _$_Transfer.fromJson;
}

/// @nodoc
abstract class _$$_CategoryCopyWith<$Res> {
  factory _$$_CategoryCopyWith(
          _$_Category value, $Res Function(_$_Category) then) =
      __$$_CategoryCopyWithImpl<$Res>;
  @useResult
  $Res call({Category category});
}

/// @nodoc
class __$$_CategoryCopyWithImpl<$Res>
    extends _$CategoryFilterCopyWithImpl<$Res, _$_Category>
    implements _$$_CategoryCopyWith<$Res> {
  __$$_CategoryCopyWithImpl(
      _$_Category _value, $Res Function(_$_Category) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
  }) {
    return _then(_$_Category(
      null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Category extends _Category {
  const _$_Category(this.category, {final String? $type})
      : $type = $type ?? 'category',
        super._();

  factory _$_Category.fromJson(Map<String, dynamic> json) =>
      _$$_CategoryFromJson(json);

  @override
  final Category category;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CategoryFilter.category(category: $category)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Category &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CategoryCopyWith<_$_Category> get copyWith =>
      __$$_CategoryCopyWithImpl<_$_Category>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function() income,
    required TResult Function() expense,
    required TResult Function() transfer,
    required TResult Function(Category category) category,
    required TResult Function(List<Category> categories) categories,
  }) {
    return category(this.category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function()? income,
    TResult? Function()? expense,
    TResult? Function()? transfer,
    TResult? Function(Category category)? category,
    TResult? Function(List<Category> categories)? categories,
  }) {
    return category?.call(this.category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function()? income,
    TResult Function()? expense,
    TResult Function()? transfer,
    TResult Function(Category category)? category,
    TResult Function(List<Category> categories)? categories,
    required TResult orElse(),
  }) {
    if (category != null) {
      return category(this.category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_All value) all,
    required TResult Function(_Income value) income,
    required TResult Function(_Expense value) expense,
    required TResult Function(_Transfer value) transfer,
    required TResult Function(_Category value) category,
    required TResult Function(_Categories value) categories,
  }) {
    return category(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Income value)? income,
    TResult? Function(_Expense value)? expense,
    TResult? Function(_Transfer value)? transfer,
    TResult? Function(_Category value)? category,
    TResult? Function(_Categories value)? categories,
  }) {
    return category?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Income value)? income,
    TResult Function(_Expense value)? expense,
    TResult Function(_Transfer value)? transfer,
    TResult Function(_Category value)? category,
    TResult Function(_Categories value)? categories,
    required TResult orElse(),
  }) {
    if (category != null) {
      return category(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_CategoryToJson(
      this,
    );
  }
}

abstract class _Category extends CategoryFilter {
  const factory _Category(final Category category) = _$_Category;
  const _Category._() : super._();

  factory _Category.fromJson(Map<String, dynamic> json) = _$_Category.fromJson;

  Category get category;
  @JsonKey(ignore: true)
  _$$_CategoryCopyWith<_$_Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_CategoriesCopyWith<$Res> {
  factory _$$_CategoriesCopyWith(
          _$_Categories value, $Res Function(_$_Categories) then) =
      __$$_CategoriesCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Category> categories});
}

/// @nodoc
class __$$_CategoriesCopyWithImpl<$Res>
    extends _$CategoryFilterCopyWithImpl<$Res, _$_Categories>
    implements _$$_CategoriesCopyWith<$Res> {
  __$$_CategoriesCopyWithImpl(
      _$_Categories _value, $Res Function(_$_Categories) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
  }) {
    return _then(_$_Categories(
      null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Categories extends _Categories {
  const _$_Categories(final List<Category> categories, {final String? $type})
      : _categories = categories,
        $type = $type ?? 'categories',
        super._();

  factory _$_Categories.fromJson(Map<String, dynamic> json) =>
      _$$_CategoriesFromJson(json);

  final List<Category> _categories;
  @override
  List<Category> get categories {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'CategoryFilter.categories(categories: $categories)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Categories &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_categories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CategoriesCopyWith<_$_Categories> get copyWith =>
      __$$_CategoriesCopyWithImpl<_$_Categories>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() all,
    required TResult Function() income,
    required TResult Function() expense,
    required TResult Function() transfer,
    required TResult Function(Category category) category,
    required TResult Function(List<Category> categories) categories,
  }) {
    return categories(this.categories);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? all,
    TResult? Function()? income,
    TResult? Function()? expense,
    TResult? Function()? transfer,
    TResult? Function(Category category)? category,
    TResult? Function(List<Category> categories)? categories,
  }) {
    return categories?.call(this.categories);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? all,
    TResult Function()? income,
    TResult Function()? expense,
    TResult Function()? transfer,
    TResult Function(Category category)? category,
    TResult Function(List<Category> categories)? categories,
    required TResult orElse(),
  }) {
    if (categories != null) {
      return categories(this.categories);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_All value) all,
    required TResult Function(_Income value) income,
    required TResult Function(_Expense value) expense,
    required TResult Function(_Transfer value) transfer,
    required TResult Function(_Category value) category,
    required TResult Function(_Categories value) categories,
  }) {
    return categories(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_All value)? all,
    TResult? Function(_Income value)? income,
    TResult? Function(_Expense value)? expense,
    TResult? Function(_Transfer value)? transfer,
    TResult? Function(_Category value)? category,
    TResult? Function(_Categories value)? categories,
  }) {
    return categories?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_All value)? all,
    TResult Function(_Income value)? income,
    TResult Function(_Expense value)? expense,
    TResult Function(_Transfer value)? transfer,
    TResult Function(_Category value)? category,
    TResult Function(_Categories value)? categories,
    required TResult orElse(),
  }) {
    if (categories != null) {
      return categories(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_CategoriesToJson(
      this,
    );
  }
}

abstract class _Categories extends CategoryFilter {
  const factory _Categories(final List<Category> categories) = _$_Categories;
  const _Categories._() : super._();

  factory _Categories.fromJson(Map<String, dynamic> json) =
      _$_Categories.fromJson;

  List<Category> get categories;
  @JsonKey(ignore: true)
  _$$_CategoriesCopyWith<_$_Categories> get copyWith =>
      throw _privateConstructorUsedError;
}
