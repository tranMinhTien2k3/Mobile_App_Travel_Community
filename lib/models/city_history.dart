import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_history.freezed.dart';
part 'city_history.g.dart';

CityHistory cityHistoryFromJson(Map<String, dynamic> str) => CityHistory.fromJson(str);
String cityHistoryToJson(CityHistory data) => json.encode(data.toJson());

@freezed 
class CityHistory with _$CityHistory{
  const factory CityHistory({
    required String history
  }) = _CityHistory;
  factory CityHistory.fromJson(Map<String, dynamic> json) => _$CityHistoryFromJson(json);

}
