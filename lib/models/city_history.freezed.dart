// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'city_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CityHistory _$CityHistoryFromJson(Map<String, dynamic> json) {
  return _CityHistory.fromJson(json);
}

/// @nodoc
mixin _$CityHistory {
  String get history => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CityHistoryCopyWith<CityHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CityHistoryCopyWith<$Res> {
  factory $CityHistoryCopyWith(
          CityHistory value, $Res Function(CityHistory) then) =
      _$CityHistoryCopyWithImpl<$Res, CityHistory>;
  @useResult
  $Res call({String history});
}

/// @nodoc
class _$CityHistoryCopyWithImpl<$Res, $Val extends CityHistory>
    implements $CityHistoryCopyWith<$Res> {
  _$CityHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? history = null,
  }) {
    return _then(_value.copyWith(
      history: null == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CityHistoryImplCopyWith<$Res>
    implements $CityHistoryCopyWith<$Res> {
  factory _$$CityHistoryImplCopyWith(
          _$CityHistoryImpl value, $Res Function(_$CityHistoryImpl) then) =
      __$$CityHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String history});
}

/// @nodoc
class __$$CityHistoryImplCopyWithImpl<$Res>
    extends _$CityHistoryCopyWithImpl<$Res, _$CityHistoryImpl>
    implements _$$CityHistoryImplCopyWith<$Res> {
  __$$CityHistoryImplCopyWithImpl(
      _$CityHistoryImpl _value, $Res Function(_$CityHistoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? history = null,
  }) {
    return _then(_$CityHistoryImpl(
      history: null == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CityHistoryImpl implements _CityHistory {
  const _$CityHistoryImpl({required this.history});

  factory _$CityHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CityHistoryImplFromJson(json);

  @override
  final String history;

  @override
  String toString() {
    return 'CityHistory(history: $history)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CityHistoryImpl &&
            (identical(other.history, history) || other.history == history));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, history);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CityHistoryImplCopyWith<_$CityHistoryImpl> get copyWith =>
      __$$CityHistoryImplCopyWithImpl<_$CityHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CityHistoryImplToJson(
      this,
    );
  }
}

abstract class _CityHistory implements CityHistory {
  const factory _CityHistory({required final String history}) =
      _$CityHistoryImpl;

  factory _CityHistory.fromJson(Map<String, dynamic> json) =
      _$CityHistoryImpl.fromJson;

  @override
  String get history;
  @override
  @JsonKey(ignore: true)
  _$$CityHistoryImplCopyWith<_$CityHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
