// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:travel_app/models/city_history.dart';
// import 'package:travel_app/models/city_model.dart';
// import 'package:travel_app/models/country_model.dart';
// import 'package:travel_app/models/photo_model.dart';
// import 'package:travel_app/repositories/city_repository.dart';
// import 'package:travel_app/repositories/photo_repository.dart';

// final countryRepositoryProvider = Provider((ref) => CountryReponsitory());
// final photoRepositoryProvider = Provider((ref) => PhotoRepository());

// final countryProvider = FutureProvider<CountryModel>((ref) async {
//   final countryRepository = ref.read(countryRepositoryProvider);
//   return countryRepository.getCountryCodes();
// });

// // final cityHistoryProvider = FutureProvider.family<CityHistory>((ref, cityName) async{
// //   final cityRepository = ref.read(countryRepositoryProvider);
// //   return cityRepository.getHistory(cityName);
// // });

// final cityProvider = FutureProvider.family<List<City>, String>((ref, countryCode) async {
//   final cityRepository = ref.read(countryRepositoryProvider);
//   return cityRepository.getCities(countryCode);
// });

// final cityHistoryProvider = FutureProvider.family<CityHistory, String>((ref, cityName) async{
//   final cityHistoryRepository = ref.read(countryRepositoryProvider);
//   return cityHistoryRepository.getHistory(cityName);
// });

// final citiesProvider = FutureProvider<List<City>>((ref) async {
//   final countryModel = await ref.read(countryRepositoryProvider).getCountryCodes();
//   final countryCode = countryModel.iso2;
//   return ref.read(countryRepositoryProvider).getCities(countryCode);
// });


// final cityPhotoProvider = FutureProvider.family<Photo, String>((ref, cityName) async {
//   final photoRepository = ref.read(photoRepositoryProvider);
//   return photoRepository.fetchPhoto(cityName);
// });
