import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:travel_app/models/city_history.dart';
import 'package:travel_app/models/city_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/models/country.dart';
import 'package:travel_app/models/country_model.dart';
import 'package:travel_app/services/api_service.dart';


final apiProvider = Provider((ref) => ApiService());

final countryProvider = FutureProvider.autoDispose<List<CountryModel>>((ref) {
  return ref.read(apiProvider).getCountry().then((countriesData) {
    final List<CountryModel> countryList = [];
    for (var i = 0; i < 100; i++) {
      countryList.add(
        CountryModel(
          iso2: countriesData[i]['iso2'],
          name: countriesData[i]['name'],
          region: countriesData[i]['region'],
        ),
      );
    }
    return countryList;
  });
});

final countryProvider2 = FutureProvider.autoDispose<List<Country>>((ref){
  return ref.read(apiProvider).getCountry2().then((countries){
    final List<Country> countryList2 = [];
    for(var i = 0; i < 227; i++){
      countryList2.add(
        Country(
          iso2: countries[i]['iso2'], 
          name: countries[i]['country']
        )
      );
    }
    return countryList2;
  });
});

// final dioProvider = Provider((ref) => Dio());

// class CountryReponsitory {
//   final String apiKey = dotenv.env['NINJA_API_KEY']!;
//   final String countryApiKey = dotenv.env['COUNTRY_API_KEY']!;
//   final String unsplashAccessKey = dotenv.env['UNSPLASH_ACCESS_KEY']!;

//   final dio = Dio();
//   Future<List<City>> getCities(String countryCode) async {
//   final url = 'https://api.api-ninjas.com/v1/country/$countryCode/city?limit=100';
  
//   try {
//     final response = await dio.get(url);
//     if (response.statusCode == 200) {
//       final List<dynamic> cityDataList = json.decode(response.data);
//       final List<City> cities = cityDataList.map((jsonData) => City.fromJson(jsonData)).toList();
//       return cities;
//     } else {
//       throw Exception('Failed to load cities');
//     }
//   } catch (e) {
//     throw Exception("ERROR: $e");
//   }
// }


//   Future<CountryModel> getCountryCodes() async {
//     var headers = {
//       'X-Api-Key': 'a5oMfz8znXVnmoJDMVe4+A==LLW2t2bh0SsOZrEe'
//     };
//     final url = 'https://api.api-ninjas.com/v1/country?limit=100';
    
//     try {
//       final response = await dio.get(
//         url,
//         options: Options(
//           headers: headers
//         )
//       );
//       if (response.statusCode == 200) {
//         final List<dynamic> countriesData = response.data;
//         final countryModel = CountryModel.fromJson(countriesData[0]);
//         return countryModel;
//       } else {
//         throw Exception('Failed to load country codes');
//       }
//     } catch (e) {
//       throw Exception('Network Error: $e');
//     }
//   }

//   Future<List<City>> getCitiesFromCountryCode() async {
//   try {
    
   
//     final CountryModel countryModel = await getCountryCodes();

//     // Lấy mã quốc gia từ CountryModel
//     final String countryCode = countryModel.iso2;

//     // Sử dụng mã quốc gia để lấy danh sách thành phố
//     final List<City> cities = await getCities(countryCode);

//     return cities;

//   } catch (e) {
//     throw Exception("Error getting cities from country code: $e");
//   }
// }


//   Future<CityHistory> getHistory(String cityName) async{
//     final url = 'https://en.wikipedia.org/api/rest_v1/page/summary/$cityName';
//     try{
//       final response = await dio.get(url);
//       if(response.statusCode == 200){
//         final Map<String, dynamic> jsonData = json.decode(response.data);
//         return CityHistory.fromJson(jsonData);
//       }
//       else{
//         throw Exception('Failed to load city history');
//       }
//     } catch (e){
//       throw Exception('ERROR: $e');
//     }
//   }
  

  // Future<Either<String, List<City>>> fetchCities() async {
  //   final client = await http.Client();
  //   try {
  //     final response = await client.get(Uri.parse('https://api.api-ninjas.com/v1/city=Hanoi'), headers: {
  //       'X-Api-Key': 'a5oMfz8znXVnmoJDMVe4+A==LLW2t2bh0SsOZrEe',
  //     });
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body) as List;
  //       final cities = data.map((cityJson) => City.fromJson(cityJson)).toList();
  //       return Right(cities);
  //     } else {
  //       return Left('Failed to load cities');
  //     }
  //   } catch (e) {
  //     return Left('Network error: $e');
  //   }
  // }

  // Future<Either<String, String>> fetchCityHistory(String cityName) async {
  //   try {
  //     // Ví dụ sử dụng Wikipedia API để lấy lịch sử của thành phố
  //     final response = await http.get(Uri.parse('https://en.wikipedia.org/api/rest_v1/page/summary/$cityName'));
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       final history = data['extract'];
  //       return Right(history);
  //     } else {
  //       return Left('Failed to load city history');
  //     }
  //   } catch (e) {
  //     return Left('Network error: $e');
  //   }
  // }
// }
