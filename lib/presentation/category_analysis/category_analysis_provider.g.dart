// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_analysis_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String $summaryDataHash() => r'a749bb7aa66af7a34c8a2f506ad4a192e2998cd3';

/// See also [summaryData].
class SummaryDataProvider extends AutoDisposeProvider<AsyncValue<SummaryData>> {
  SummaryDataProvider({
    required this.filter,
    required this.category,
  }) : super(
          (ref) => summaryData(
            ref,
            filter: filter,
            category: category,
          ),
          from: summaryDataProvider,
          name: r'summaryDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $summaryDataHash,
        );

  final DateFilter filter;
  final int category;

  @override
  bool operator ==(Object other) {
    return other is SummaryDataProvider &&
        other.filter == filter &&
        other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef SummaryDataRef = AutoDisposeProviderRef<AsyncValue<SummaryData>>;

/// See also [summaryData].
final summaryDataProvider = SummaryDataFamily();

class SummaryDataFamily extends Family<AsyncValue<SummaryData>> {
  SummaryDataFamily();

  SummaryDataProvider call({
    required DateFilter filter,
    required int category,
  }) {
    return SummaryDataProvider(
      filter: filter,
      category: category,
    );
  }

  @override
  AutoDisposeProvider<AsyncValue<SummaryData>> getProviderOverride(
    covariant SummaryDataProvider provider,
  ) {
    return call(
      filter: provider.filter,
      category: provider.category,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'summaryDataProvider';
}

String $expinDatasFilterHash() => r'065e75377d056e598cc764366cf83a20d7e702c8';

/// See also [expinDatasFilter].
class ExpinDatasFilterProvider
    extends AutoDisposeProvider<AsyncValue<List<ExpinData>>> {
  ExpinDatasFilterProvider({
    required this.filter,
    required this.category,
  }) : super(
          (ref) => expinDatasFilter(
            ref,
            filter: filter,
            category: category,
          ),
          from: expinDatasFilterProvider,
          name: r'expinDatasFilterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $expinDatasFilterHash,
        );

  final DateFilter filter;
  final int category;

  @override
  bool operator ==(Object other) {
    return other is ExpinDatasFilterProvider &&
        other.filter == filter &&
        other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef ExpinDatasFilterRef
    = AutoDisposeProviderRef<AsyncValue<List<ExpinData>>>;

/// See also [expinDatasFilter].
final expinDatasFilterProvider = ExpinDatasFilterFamily();

class ExpinDatasFilterFamily extends Family<AsyncValue<List<ExpinData>>> {
  ExpinDatasFilterFamily();

  ExpinDatasFilterProvider call({
    required DateFilter filter,
    required int category,
  }) {
    return ExpinDatasFilterProvider(
      filter: filter,
      category: category,
    );
  }

  @override
  AutoDisposeProvider<AsyncValue<List<ExpinData>>> getProviderOverride(
    covariant ExpinDatasFilterProvider provider,
  ) {
    return call(
      filter: provider.filter,
      category: provider.category,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'expinDatasFilterProvider';
}

String $paymentDatasFilterHash() => r'2ecc3076c9d59b5256eeb93e55e5cbe9bb21f95e';

/// See also [paymentDatasFilter].
class PaymentDatasFilterProvider
    extends AutoDisposeProvider<AsyncValue<List<PaymentData>>> {
  PaymentDatasFilterProvider({
    required this.filter,
    required this.category,
  }) : super(
          (ref) => paymentDatasFilter(
            ref,
            filter: filter,
            category: category,
          ),
          from: paymentDatasFilterProvider,
          name: r'paymentDatasFilterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : $paymentDatasFilterHash,
        );

  final DateFilter filter;
  final int category;

  @override
  bool operator ==(Object other) {
    return other is PaymentDatasFilterProvider &&
        other.filter == filter &&
        other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, filter.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef PaymentDatasFilterRef
    = AutoDisposeProviderRef<AsyncValue<List<PaymentData>>>;

/// See also [paymentDatasFilter].
final paymentDatasFilterProvider = PaymentDatasFilterFamily();

class PaymentDatasFilterFamily extends Family<AsyncValue<List<PaymentData>>> {
  PaymentDatasFilterFamily();

  PaymentDatasFilterProvider call({
    required DateFilter filter,
    required int category,
  }) {
    return PaymentDatasFilterProvider(
      filter: filter,
      category: category,
    );
  }

  @override
  AutoDisposeProvider<AsyncValue<List<PaymentData>>> getProviderOverride(
    covariant PaymentDatasFilterProvider provider,
  ) {
    return call(
      filter: provider.filter,
      category: provider.category,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'paymentDatasFilterProvider';
}
