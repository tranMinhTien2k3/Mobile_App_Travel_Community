import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/repositories/favorite_provider.dart';
import 'package:travel_app/repositories/get_firebase_data.dart';




final getFirebaseDataProvider = Provider<GetFirebaseData>((ref){
  final firestore = ref.watch(firestoreProvider);
  final auth = ref.watch(authProvider);
  return GetFirebaseData(firestore, auth);
});

final getCountryFavoriteProvider = FutureProviderFamily<List<String>, String>((ref, userId) async{
  final manager = ref.watch(getFirebaseDataProvider);
  return manager.getCountryFavorite(userId);
});

final getCityFavoriteProvider = FutureProviderFamily<List<String>, String>((ref, userId) async{
  final manager = ref.watch(getFirebaseDataProvider);
  return manager.getCityFavoriteList(userId);
});