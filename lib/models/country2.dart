
import 'package:freezed_annotation/freezed_annotation.dart';
part 'country2.freezed.dart';
part 'country2.g.dart';

@freezed
class Country2 with _$Country2 {
  const factory Country2({
    required String iso2,
    required String iso3,
    required String country,
    required List<String> cities,
  }) = _Country2;

  factory Country2.fromJson(Map<String, dynamic> json) => _$Country2FromJson(json);
}
