import 'package:hooks_riverpod/hooks_riverpod.dart';

extension ObjectExt<T> on T {
  R let<R>(R Function(T value) op) => op(this);
}

extension ChildAsync<T> on AsyncValue<T> {
  AsyncValue<R> merge<R>(AsyncValue<R> Function(T value) asyncValue) => when(
        data: (data) => asyncValue(data),
        error: (error, stackTrace) => AsyncError<R>(error, stackTrace),
        loading: () => AsyncLoading<R>(),
      );
}

extension NestedAsync<T> on AsyncValue<AsyncValue<T>> {
  AsyncValue<T> get mergeData => when(
        data: (data) => data,
        error: (error, stackTrace) => AsyncError<T>(error, stackTrace),
        loading: () => AsyncLoading<T>(),
      );
}
