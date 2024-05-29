import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:travel_app/models/city_model.dart';

class CityRepository {
  final String apiKey = dotenv.env['NINJA_API_KEY']!;

  Future<Either<String, List<City>>> fetchCities() async {
    try {
      final response = await http.get(Uri.parse('https://api.api-ninjas.com/v1/city?limit=10'), headers: {
        'X-Api-Key': apiKey,
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        final cities = data.map((cityJson) => City.fromJson(cityJson)).toList();
        return Right(cities);
      } else {
        return Left('Failed to load cities');
      }
    } catch (e) {
      return Left('Network error: $e');
    }
  }

  Future<Either<String, String>> fetchCityHistory(String cityName) async {
    try {
      // Ví dụ sử dụng Wikipedia API để lấy lịch sử của thành phố
      final response = await http.get(Uri.parse('https://en.wikipedia.org/api/rest_v1/page/summary/$cityName'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final history = data['extract'];
        return Right(history);
      } else {
        return Left('Failed to load city history');
      }
    } catch (e) {
      return Left('Network error: $e');
    }
  }
}
