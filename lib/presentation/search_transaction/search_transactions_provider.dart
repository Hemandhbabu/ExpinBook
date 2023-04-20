import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/expin_data.dart';
import '../../provider/use_cases_provider.dart';

enum SearchFilter {
  all('All'),
  amount('Amount'),
  description('Description'),
  category('Category'),
  payment('Payment');

  final String name;

  const SearchFilter(this.name);
}

class SearchTransactionsProvider {
  const SearchTransactionsProvider._();
  static final elevatedProvider = StateProvider.autoDispose((ref) => false);
  static final queryProvider = StateProvider.autoDispose((ref) => '');
  static final filterProvider =
      StateProvider.autoDispose((ref) => SearchFilter.all);

  static final searchTransactionsProvider = StreamProvider.autoDispose(
    (ref) {
      final filter = ref.watch(filterProvider);
      final query = ref.watch(queryProvider).toLowerCase();
      if (query.isEmpty) return Stream.value(const <ExpinData>[]);
      return ref.watch(
        expinDataUseCasesProvider.select(
          (value) => value.getAllExpinData.watchAll().map(
                (value) => value.where((element) {
                  switch (filter) {
                    case SearchFilter.all:
                      return '${element.expin.amount}'.contains(query) ||
                          (element.expin.description
                                  ?.toLowerCase()
                                  .contains(query) ??
                              false) ||
                          element.when(
                            expin: (element) =>
                                element.categoryName
                                    .toLowerCase()
                                    .contains(query) ||
                                element.paymentName
                                    .toLowerCase()
                                    .contains(query),
                            transfer: (element) =>
                                element.fromPaymentName
                                    .toLowerCase()
                                    .contains(query) ||
                                element.toPaymentName
                                    .toLowerCase()
                                    .contains(query),
                          );
                    case SearchFilter.amount:
                      return '${element.expin.amount}'.contains(query);
                    case SearchFilter.description:
                      return element.expin.description
                              ?.toLowerCase()
                              .contains(query) ??
                          false;
                    case SearchFilter.category:
                      return element.when(
                        expin: (element) =>
                            element.categoryName.toLowerCase().contains(query),
                        transfer: (_) => false,
                      );
                    case SearchFilter.payment:
                      return element.when(
                        expin: (element) =>
                            element.paymentName.toLowerCase().contains(query),
                        transfer: (element) =>
                            element.fromPaymentName
                                .toLowerCase()
                                .contains(query) ||
                            element.toPaymentName.toLowerCase().contains(query),
                      );
                  }
                }).toList(),
              ),
        ),
      );
    },
  );
}
