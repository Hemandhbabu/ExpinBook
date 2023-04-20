import '../../provider/use_cases_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllTransactionsProvider {
  const AllTransactionsProvider._();
  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final allTransactionsProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(
      expinDataUseCasesProvider.select(
        (value) => value.getAllExpinData.watchAll(),
      ),
    ),
  );
}
