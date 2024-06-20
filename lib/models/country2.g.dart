// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$Country2Impl _$$Country2ImplFromJson(Map<String, dynamic> json) =>
    _$Country2Impl(
      iso2: json['iso2'] as String,
      iso3: json['iso3'] as String,
      country: json['country'] as String,
      cities:
          (json['cities'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$Country2ImplToJson(_$Country2Impl instance) =>
    <String, dynamic>{
      'iso2': instance.iso2,
      'iso3': instance.iso3,
      'country': instance.country,
      'cities': instance.cities,
    };
