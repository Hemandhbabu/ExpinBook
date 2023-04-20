import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/expin_data.dart';

part 'expin_list_data.freezed.dart';

@freezed
class ExpinListData with _$ExpinListData {
  const factory ExpinListData.date(DateTime dateTime, int count) = _Date;
  const factory ExpinListData.data(ExpinData data) = _Data;
}
