import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/models/city_model.dart';
import 'package:travel_app/models/photo_model.dart';
import 'package:travel_app/repositories/city_repository.dart';
import 'package:travel_app/repositories/photo_repository.dart';

final cityRepositoryProvider = Provider((ref) => CityRepository());
final photoRepositoryProvider = Provider((ref) => PhotoRepository());

final citiesProvider = FutureProvider<Either<String, List<City>>>((ref) async {
  final cityRepository = ref.read(cityRepositoryProvider);
  return cityRepository.fetchCities();
});

final cityHistoryProvider = FutureProvider.family<Either<String, String>, String>((ref, cityName) async{
  final cityRepository = ref.read(cityRepositoryProvider);
  return cityRepository.fetchCityHistory(cityName);
});

final cityPhotoProvider = FutureProvider.family<Either<String, Photo>, String>((ref, cityName) async {
  final photoRepository = ref.read(photoRepositoryProvider);
  return photoRepository.fetchPhoto(cityName);
});