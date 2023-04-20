import 'package:freezed_annotation/freezed_annotation.dart';

part 'type_filter_list_data.freezed.dart';

@freezed
class TypeFilterListData<T> with _$TypeFilterListData<T> {
  const factory TypeFilterListData.title(bool isIncome) = _Title<T>;
  const factory TypeFilterListData.value(T value) = _Value<T>;
}
