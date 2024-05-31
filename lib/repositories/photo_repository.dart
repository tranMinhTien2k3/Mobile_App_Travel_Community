import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:travel_app/models/photo_model.dart';

class PhotoRepository {
  final String accessKey = dotenv.env['UNSPLASH_ACCESS_KEY']!;

  Future<Photo> fetchPhoto(String query) async {
  try {
    final response = await http.get(Uri.parse('https://api.unsplash.com/search/photos?query=$query&client_id=u6ZnwBQca6U5OOV_E9tyh-PH4c8WNippr2-RqYY5-0Y&per_page=1'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if ((data['results'] as List).isNotEmpty) {
        final photo = Photo.fromJson(data['results'][0]);
        return photo;
      } else {
        throw Exception('No photos found');
      }
    } else {
      throw Exception('Failed to load photo');
    }
  } catch (e) {
    throw Exception('Network error: $e');
  }
}

}
