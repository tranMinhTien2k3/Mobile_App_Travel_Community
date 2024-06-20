import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

Photo_photoFromJson(Map<String, dynamic> str) => Photo.fromJson(str);
String _photoToJson(Photo data) => json.encode(data.toJson());

@freezed
class Photo with _$Photo {
  const factory Photo({
    required String id,
    required Map<String, String> urls,
    String? description,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}
