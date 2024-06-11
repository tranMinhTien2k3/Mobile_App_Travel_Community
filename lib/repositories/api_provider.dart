import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/models/city_model.dart';
import 'package:travel_app/models/country.dart';
import 'package:travel_app/services/api_service.dart';

final apiProvider = Provider((ref) => ApiService());


// Provider for fetchCountry
final countriesProvider = FutureProvider<List<Country>>((ref) async {
  final apiService = ref.watch(apiProvider);
  return await apiService.fetchCountries();
});


// Provider for fetchCities
final citiesProvider = FutureProvider.autoDispose.family<List<City>, String>(
  (ref, iso2) async{
    final apiService = ref.watch(apiProvider);
    return await apiService.fetchCities(iso2);
  }
);




// Provider for get City information
final wikiProvider = FutureProvider.autoDispose.family<Map<String,dynamic>, String>(
  (ref, cityName) async{
    final apiService = ref.read(apiProvider);
    try {
      final wikiData = await apiService.fetchWikiData(cityName);
      return wikiData;
    } catch (error) {
      // Xử lý lỗi ở đây, ví dụ:
      print('Error fetching wiki data: $error');
      throw Exception('Failed to fetch wiki data');
    }
  }
);




// Provider for getImage
final photoProvider = FutureProvider.autoDispose.family<String, String>((ref, countryName) async{
  final apiService = ref.read(apiProvider);
  final photo = await apiService.getImage(countryName);
  return photo;
});


final imageProvider = FutureProvider.family<String, String>((ref, query) async {
  final apiService = ref.watch(apiProvider);
  return await apiService.fetchImageUrl(query);
});









