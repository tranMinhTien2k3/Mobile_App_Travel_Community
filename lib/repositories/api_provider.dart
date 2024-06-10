import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/models/city_model.dart';
import 'package:travel_app/models/country.dart';
import 'package:travel_app/models/country2.dart';
import 'package:travel_app/models/country_model.dart';
import 'package:travel_app/models/photo_model.dart';
import 'package:travel_app/models/wiki_model.dart';
import 'package:travel_app/services/api_service.dart';

final apiProvider = Provider((ref) => ApiService());


// final countryProvider = FutureProvider.autoDispose<List<CountryModel>>((ref) {
//   return ref.read(apiProvider).getCountry2().then((countriesData) {
//     final List<CountryModel> countryList = [];
//     for (var i = 0; i < 100; i++) {
//       countryList.add(
//         CountryModel(
//           iso2: countriesData[i]['iso2'],
//           name: countriesData[i]['name'],
//           region: countriesData[i]['region'],
//         ),
//       );
//     }
//     return countryList;
//   });
// });


// Provider for fetchCountry
final countriesProvider = FutureProvider<List<Country>>((ref) async {
  final apiService = ref.watch(apiProvider);
  return await apiService.fetchCountries();
});

final citiesProvider = FutureProvider.autoDispose.family<List<City>, String>(
  (ref, iso2) async{
    final apiService = ref.watch(apiProvider);
    return await apiService.fetchCities(iso2);
  }
);




// final countryProvider2 = FutureProvider.autoDispose<List<Country>>((ref){
//   return ref.read(apiProvider).getCountry2().then((countries){
//     final List<Country> countryList2 = [];
//     for(var i = 0; i < 227; i++){
//       countryList2.add(
//         Country(
//           iso2: countries[i]['iso2'], 
//           name: countries[i]['country']
//         )
//       );
//     }
//     return countryList2;
//   });
// });


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



// final citiesProvider = FutureProvider.autoDispose.family<List<City>, String>((ref, iso2) async {
//   final apiService = ref.read(apiProvider);
//   final cities = await apiService.getCities(iso2);

//   // Debug log

//   final List<City> cityList = cities.take(30).toList();
//   return cityList;
// });

final photoProvider = FutureProvider.autoDispose.family<String, String>((ref, countryName) async{
  final apiService = ref.read(apiProvider);
  final photo = await apiService.getImage(countryName);
  return photo;
});


final imageProvider = FutureProvider.family<String, String>((ref, query) async {
  final apiService = ref.watch(apiProvider);
  return await apiService.fetchImageUrl(query);
});









