extension DoubleIterable on Iterable<double> {
  double get addition => isEmpty ? 0.0 : reduce((o, t) => o + t);
  double get max {
    double amount = 0.0;
    forEach((value) {
      if (value > amount) amount = value;
    });
    return amount;
  }
}

extension IntIterable on Iterable<int> {
  int get addition => isEmpty ? 0 : reduce((o, t) => o + t);
  int get max {
    int amount = 0;
    forEach((value) {
      if (value > amount) amount = value;
    });
    return amount;
  }
}

typedef Bool<T> = bool Function(T item);
typedef Same<T> = bool Function(T one, T two);
typedef Reduce<T, V> = V? Function(T item);

extension FutureList<T> on Iterable<Future<T>> {
  Future<List<T>> get toFuture async {
    final result = <T>[];
    for (var element in this) {
      result.add(await element);
    }
    return result;
  }
}

extension NullList<T> on Iterable<T?> {
  List<T> get removeNulls => reduceToField(
        (item) => item,
        (one, two) => false,
      );
}

extension MyList<T> on Iterable<T> {
  T? findItem(Bool<T> callback) {
    for (var listItem in this) {
      if (callback(listItem)) return listItem;
    }
    return null;
  }

  List<V> reduceToField<V>(Reduce<T, V> change, Same<V> reduce) {
    final List<V> vList = [];
    for (var item1 in this) {
      final value = change(item1);
      if (value != null) if (!_isSame(value, vList, reduce)) vList.add(value);
    }
    return vList;
  }

  bool _isSame<V>(V value, List<V> data, Same<V> callback) {
    for (var item in data) {
      final boo = callback(item, value);
      if (boo) return true;
    }
    return false;
  }
}
