
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/models/city_model.dart';
import 'package:travel_app/models/country_model.dart';

final dio = Dio();
  final String apiKey = dotenv.env['NINJA_API_KEY']!;
  final String countryApiKey = dotenv.env['COUNTRY_API_KEY']!;
  final String unsplashAccessKey = dotenv.env['UNSPLASH_ACCESS_KEY']!;

class ApiService {
  final Dio dio = Dio();

  Future<List<dynamic>> getCountry() async {
    var headers = {
      'X-Api-Key': apiKey,
    };
    final url = 'https://api.api-ninjas.com/v1/country?limit=30';
    try {
      final response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      throw Exception('Failed to load country code');
    }
    throw Exception('Failed to load country');
  }

  Future<List<dynamic>> getCountry2() async{
    final url = 'https://countriesnow.space/api/v0.1/countries/';

    try{
      final response = await dio.get(url);
      return response.data['data'];
    } catch(e){
      throw Exception('$e');
    }
  }

  // Future<List<City>> getCities(String iso2) async {
  //   final url = 'https://api.api-ninjas.com/v1/city?country=$iso2';

  //   try {
  //     final response = await dio.get(url, options: Options(
  //       headers: {
  //         'X-Api-Key': apiKey,
  //       },
  //     ));
  //     List<dynamic> data = response.data;
  //     return data.map<City>((city) => City.fromJson(city)).toList();
  //   } catch (e) {
  //     throw Exception('Failed to load cities for $iso2: $e');
  //   }
  // }

 Future<List<City>> getCities(String iso2) async {
    final url = 'https://api.api-ninjas.com/v1/city?country=$iso2&limit=30';

    try {
      print('Requesting URL: $url'); // Debug log
      final response = await dio.get(url, options: Options(
        headers: {
          'X-Api-Key': apiKey,
        },
      ));
      print('Response status: ${response.statusCode}'); // Debug log
      print('Response data: ${response.data}'); // Debug log

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map<City>((city) => City.fromJson(city)).toList();
      } else {
        throw Exception('Failed to load cities for $iso2 with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e'); // Debug log
      throw Exception('Failed to load cities for $iso2: $e');
    }
  }
}