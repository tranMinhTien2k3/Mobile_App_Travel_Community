import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/models/city_firebase_model.dart';
import 'package:travel_app/models/country.dart';
import 'package:travel_app/models/country_firebase_data_model.dart';
import 'package:travel_app/repositories/favorite_provider.dart';
import 'package:travel_app/repositories/get_firebase_data.dart';




final getFirebaseDataProvider = Provider<GetFirebaseData>((ref){
  final firestore = ref.watch(firestoreProvider);
  final auth = ref.watch(authProvider);
  return GetFirebaseData(firestore, auth);
});

final getCountryFavoriteProvider = FutureProvider.family.autoDispose<List<CountryFirebase>, String>((ref, userId) async{
  final manager = ref.watch(getFirebaseDataProvider);
  return manager.getCountryFavorite(userId);
});

final getCityFavoriteProvider = FutureProvider.family.autoDispose<List<CityFirebase>, String>((ref, userId) async{
  final manager = ref.watch(getFirebaseDataProvider);
  return manager.getCityFavoriteList(userId);
});