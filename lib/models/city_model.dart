import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'city_model.freezed.dart';
part 'city_model.g.dart';

City _cityFromJson(Map<String, dynamic> str) => City.fromJson(str);
String _cityToJson(City data) => json.encode(data.toJson());

@freezed
class City with _$City {
  const factory City({
    required String name,
    required String country,
    required String population,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
}