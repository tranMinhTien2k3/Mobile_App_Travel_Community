import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'wiki_model.freezed.dart';
part 'wiki_model.g.dart';

// WikiModel _wikiFromJson(Map<String, dynamic> str) => WikiModel.fromJson(str);
// String _wikiToJson(WikiModel data) => json.encode(data.toJson());

@freezed
class WikiModel with _$WikiModel {
  const factory WikiModel({
    required String image,
    required String description,
    required String extract,
  }) = _WikiModel;

  factory WikiModel.fromJson(Map<String, dynamic> json) => _$WikiModelFromJson(json);
  factory WikiModel.empty() => WikiModel(image: '', description: '', extract: '');
}
