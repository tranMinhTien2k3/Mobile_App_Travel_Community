// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country2.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Country2 _$Country2FromJson(Map<String, dynamic> json) {
  return _Country2.fromJson(json);
}

/// @nodoc
mixin _$Country2 {
  String get iso2 => throw _privateConstructorUsedError;
  String get iso3 => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  List<String> get cities => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $Country2CopyWith<Country2> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Country2CopyWith<$Res> {
  factory $Country2CopyWith(Country2 value, $Res Function(Country2) then) =
      _$Country2CopyWithImpl<$Res, Country2>;
  @useResult
  $Res call({String iso2, String iso3, String country, List<String> cities});
}

/// @nodoc
class _$Country2CopyWithImpl<$Res, $Val extends Country2>
    implements $Country2CopyWith<$Res> {
  _$Country2CopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iso2 = null,
    Object? iso3 = null,
    Object? country = null,
    Object? cities = null,
  }) {
    return _then(_value.copyWith(
      iso2: null == iso2
          ? _value.iso2
          : iso2 // ignore: cast_nullable_to_non_nullable
              as String,
      iso3: null == iso3
          ? _value.iso3
          : iso3 // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      cities: null == cities
          ? _value.cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Country2ImplCopyWith<$Res>
    implements $Country2CopyWith<$Res> {
  factory _$$Country2ImplCopyWith(
          _$Country2Impl value, $Res Function(_$Country2Impl) then) =
      __$$Country2ImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String iso2, String iso3, String country, List<String> cities});
}

/// @nodoc
class __$$Country2ImplCopyWithImpl<$Res>
    extends _$Country2CopyWithImpl<$Res, _$Country2Impl>
    implements _$$Country2ImplCopyWith<$Res> {
  __$$Country2ImplCopyWithImpl(
      _$Country2Impl _value, $Res Function(_$Country2Impl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iso2 = null,
    Object? iso3 = null,
    Object? country = null,
    Object? cities = null,
  }) {
    return _then(_$Country2Impl(
      iso2: null == iso2
          ? _value.iso2
          : iso2 // ignore: cast_nullable_to_non_nullable
              as String,
      iso3: null == iso3
          ? _value.iso3
          : iso3 // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      cities: null == cities
          ? _value._cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Country2Impl implements _Country2 {
  const _$Country2Impl(
      {required this.iso2,
      required this.iso3,
      required this.country,
      required final List<String> cities})
      : _cities = cities;

  factory _$Country2Impl.fromJson(Map<String, dynamic> json) =>
      _$$Country2ImplFromJson(json);

  @override
  final String iso2;
  @override
  final String iso3;
  @override
  final String country;
  final List<String> _cities;
  @override
  List<String> get cities {
    if (_cities is EqualUnmodifiableListView) return _cities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cities);
  }

  @override
  String toString() {
    return 'Country2(iso2: $iso2, iso3: $iso3, country: $country, cities: $cities)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Country2Impl &&
            (identical(other.iso2, iso2) || other.iso2 == iso2) &&
            (identical(other.iso3, iso3) || other.iso3 == iso3) &&
            (identical(other.country, country) || other.country == country) &&
            const DeepCollectionEquality().equals(other._cities, _cities));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, iso2, iso3, country,
      const DeepCollectionEquality().hash(_cities));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$Country2ImplCopyWith<_$Country2Impl> get copyWith =>
      __$$Country2ImplCopyWithImpl<_$Country2Impl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Country2ImplToJson(
      this,
    );
  }
}

abstract class _Country2 implements Country2 {
  const factory _Country2(
      {required final String iso2,
      required final String iso3,
      required final String country,
      required final List<String> cities}) = _$Country2Impl;

  factory _Country2.fromJson(Map<String, dynamic> json) =
      _$Country2Impl.fromJson;

  @override
  String get iso2;
  @override
  String get iso3;
  @override
  String get country;
  @override
  List<String> get cities;
  @override
  @JsonKey(ignore: true)
  _$$Country2ImplCopyWith<_$Country2Impl> get copyWith =>
      throw _privateConstructorUsedError;
}
