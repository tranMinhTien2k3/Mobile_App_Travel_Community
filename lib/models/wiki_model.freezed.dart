// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wiki_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WikiModel _$WikiModelFromJson(Map<String, dynamic> json) {
  return _WikiModel.fromJson(json);
}

/// @nodoc
mixin _$WikiModel {
  String get image => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get extract => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WikiModelCopyWith<WikiModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WikiModelCopyWith<$Res> {
  factory $WikiModelCopyWith(WikiModel value, $Res Function(WikiModel) then) =
      _$WikiModelCopyWithImpl<$Res, WikiModel>;
  @useResult
  $Res call({String image, String description, String extract});
}

/// @nodoc
class _$WikiModelCopyWithImpl<$Res, $Val extends WikiModel>
    implements $WikiModelCopyWith<$Res> {
  _$WikiModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? description = null,
    Object? extract = null,
  }) {
    return _then(_value.copyWith(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      extract: null == extract
          ? _value.extract
          : extract // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WikiModelImplCopyWith<$Res>
    implements $WikiModelCopyWith<$Res> {
  factory _$$WikiModelImplCopyWith(
          _$WikiModelImpl value, $Res Function(_$WikiModelImpl) then) =
      __$$WikiModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String image, String description, String extract});
}

/// @nodoc
class __$$WikiModelImplCopyWithImpl<$Res>
    extends _$WikiModelCopyWithImpl<$Res, _$WikiModelImpl>
    implements _$$WikiModelImplCopyWith<$Res> {
  __$$WikiModelImplCopyWithImpl(
      _$WikiModelImpl _value, $Res Function(_$WikiModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = null,
    Object? description = null,
    Object? extract = null,
  }) {
    return _then(_$WikiModelImpl(
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      extract: null == extract
          ? _value.extract
          : extract // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WikiModelImpl implements _WikiModel {
  const _$WikiModelImpl(
      {required this.image, required this.description, required this.extract});

  factory _$WikiModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WikiModelImplFromJson(json);

  @override
  final String image;
  @override
  final String description;
  @override
  final String extract;

  @override
  String toString() {
    return 'WikiModel(image: $image, description: $description, extract: $extract)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WikiModelImpl &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.extract, extract) || other.extract == extract));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, image, description, extract);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WikiModelImplCopyWith<_$WikiModelImpl> get copyWith =>
      __$$WikiModelImplCopyWithImpl<_$WikiModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WikiModelImplToJson(
      this,
    );
  }
}

abstract class _WikiModel implements WikiModel {
  const factory _WikiModel(
      {required final String image,
      required final String description,
      required final String extract}) = _$WikiModelImpl;

  factory _WikiModel.fromJson(Map<String, dynamic> json) =
      _$WikiModelImpl.fromJson;

  @override
  String get image;
  @override
  String get description;
  @override
  String get extract;
  @override
  @JsonKey(ignore: true)
  _$$WikiModelImplCopyWith<_$WikiModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
