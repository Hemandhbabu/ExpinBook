import 'get_all_expin_data.dart';
import 'get_expin_data.dart';

class ExpinDataUseCases {
  final GetExpinData getExpinData;
  final GetAllExpinData getAllExpinData;

  const ExpinDataUseCases({
    required this.getExpinData,
    required this.getAllExpinData,
  });
}
