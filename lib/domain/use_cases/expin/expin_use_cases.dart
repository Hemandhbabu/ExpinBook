import 'get_all_expin.dart';
import 'get_expin.dart';
import 'modify_expin.dart';

class ExpinUseCases {
  final ModifyExpin modifyExpin;
  final GetExpin getExpin;
  final GetAllExpin getAllExpin;

  const ExpinUseCases({
    required this.modifyExpin,
    required this.getExpin,
    required this.getAllExpin,
  });
}
