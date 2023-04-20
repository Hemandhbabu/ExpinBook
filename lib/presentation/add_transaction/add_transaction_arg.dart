import '../../domain/models/expin_data.dart';

class AddTransactionArg {
  final bool editable;
  final ExpinData? expinData;

  const AddTransactionArg({
    this.editable = false,
    this.expinData,
  });
}
