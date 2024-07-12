
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'country.freezed.dart';
part 'country.g.dart';

// CountryModel _countryModelFromJson(Map<String, dynamic> str) => CountryModel.fromJson(str);
// String _countryModelToJson(CountryModel data) => json.encode(data.toJson());

@freezed
class Country with _$Country{
  const factory Country({
    required String iso2,
    required String name,


  }) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  factory Country.empty() => Country(iso2: '', name: '');

  
}