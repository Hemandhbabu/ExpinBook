import '../../provider/use_cases_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentsProvider {
  const PaymentsProvider._();

  static final elevatedProvider = StateProvider.autoDispose((ref) => false);

  static final paymentsProvider = StreamProvider.autoDispose(
    (ref) => ref.watch(
      paymentUseCasesProvider.select(
        (value) => value.getAllPayment.watchAll(),
      ),
    ),
  );
}
