
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:travel_app/models/city_model.dart';
import 'package:travel_app/models/country.dart';


// AcessKey cua cac Api, luu o .env
final String apiKey = dotenv.env['NINJA_API_KEY']!;
final String countryApiKey = dotenv.env['COUNTRY_API_KEY']!;
final String unsplashAccessKey = dotenv.env['UNSPLASH_ACCESS_KEY']!;
final String? countryStateApiKey = dotenv.env['COUNTRY_STATE_API_KEY'];

class ApiService {
  final Dio dio = Dio();


  Future<List<Country>> fetchCountries() async {

    // Thêm API key vào header
    dio.options.headers['X-CSCAPI-KEY'] = countryStateApiKey;

    try {
      // Thực hiện yêu cầu GET
      final response = await dio.get('https://api.countrystatecity.in/v1/countries');

      if (response.statusCode == 200) {
        // Chuyển đổi dữ liệu JSON sang danh sách các đối tượng Country
        List<dynamic> data = response.data;
        List<Country> countries = data.map((country) => Country.fromJson(country)).toList();
        return countries;
      } else {
        // In ra thông báo lỗi và trả về danh sách rỗng
        print('Error: ${response.statusMessage}');
        return [];
      }
    } catch (e) {
      // Xử lý lỗi và trả về danh sách rỗng
      print('Error: $e');
      return [];
    }
  }


  Future<List<City>> fetchCities(String iso2) async {

    // Thêm API key vào header
    dio.options.headers['X-CSCAPI-KEY'] = countryStateApiKey;

    try {
      // Thực hiện yêu cầu GET
      final response = await dio.get('https://api.countrystatecity.in/v1/countries/$iso2/states');

      if (response.statusCode == 200) {
        // Chuyển đổi dữ liệu JSON sang danh sách các đối tượng City
        print(response.data);
        List<dynamic> data = response.data;
        List<City> cities = data.map((city) => City.fromJson(city)).toList();
        return cities;
      } else {
        // In ra thông báo lỗi và trả về danh sách rỗng
        print('Error: ${response.statusMessage}');
        return [];
      }
    } catch (e) {
      // Xử lý lỗi và trả về danh sách rỗng
      print('Error: $e');
      return [];
    }
  }


  Future<Map<String, dynamic>> fetchWikiData(String cityName) async {
    final dio = Dio();
    try {
      final response = await dio.get('https://en.wikipedia.org/api/rest_v1/page/summary/$cityName');
      if (response.statusCode == 200) {
        // Tra ve data neu ket noi thanh cong
        return response.data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      // In ra loi va tra ve map trong
      print('Error: $error');
      return {}; // Trả về một Map trống
    }
  }

  Future<String> getImage(String name) async {
    // Duong dan url den api, tham so name la ten cua thanh pho
    final url = 'https://api.unsplash.com/search/photos?query=$name&client_id=$unsplashAccessKey&per_page=1';
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        // tra ve data neu ket noi thanh cong
        final data = response.data;
        if ((data['results'] as List).isNotEmpty) {
          final photoUrl = data['results'][0]['urls']['regular'];
          return photoUrl;
        } else {
          throw Exception('No photos found for $name');
        }
      } else {
        throw Exception('Failed to load photo for $name');
      }
    } catch (e) {
      throw Exception('Failed to load image: $e');
    }
  }




  Future<String> fetchImageUrl(String query) async {
    final unsplashDio = Dio(BaseOptions(
      baseUrl: 'https://api.unsplash.com/',
      headers: {
        'Authorization': 'Client-ID ${dotenv.env['UNSPLASH_ACCESS_KEY']}',
      },
    ));

    try {
      final response = await unsplashDio.get('search/photos', queryParameters: {
        'query': query,
        'per_page': 1,
      });
      if (response.statusCode == 200 && response.data['results'].isNotEmpty) {
        return response.data['results'][0]['urls']['regular'];
      } else {
        throw Exception('No image found');
      }
    } catch (e) {
      throw Exception('Failed to fetch image: $e');
    }
  }

}

