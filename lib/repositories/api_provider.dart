import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/models/city_model.dart';
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


final citiesProvider = FutureProvider.autoDispose.family<List<City>, String>((ref, iso2) async {
  final apiService = ref.read(apiProvider);
  final cities = await apiService.getCities(iso2);

  // Debug log
  print('Cities data: $cities');

  final List<City> cityList = cities.take(30).toList();
  return cityList;
});

