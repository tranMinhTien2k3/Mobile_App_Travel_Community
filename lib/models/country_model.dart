import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'country_model.freezed.dart';
part 'country_model.g.dart';

// CountryModel _countryModelFromJson(Map<String, dynamic> str) => CountryModel.fromJson(str);
// String _countryModelToJson(CountryModel data) => json.encode(data.toJson());

@freezed
class CountryModel with _$CountryModel{
  const factory CountryModel({
    required String iso2,
    required String name,
    required String region,
    

  }) = _CountryModel;

  factory CountryModel.fromJson(Map<String, dynamic> json) => _$CountryModelFromJson(json);
  factory CountryModel.empty() => CountryModel(iso2: '', name: '', region: '');

  
}