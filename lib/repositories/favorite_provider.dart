import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/repositories/add_to_favourite.dart';
import 'package:travel_app/repositories/auth_provider.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);


final favoriteManagerProvider = Provider<FavoriteController>((ref){
  final firestore = ref.watch(firestoreProvider);
  final auth = ref.watch(authProvider);
  return FavoriteController(firestore, auth);
});

// Provider for favorite status of a country
final favoriteStatusProvider = FutureProvider.family<bool, String>((ref, countryName) async {
  final manager = ref.watch(favoriteManagerProvider);
  return manager.isFavorite(countryName);
});

// Provider for favorite count of a country
final favoriteCountProvider = FutureProvider.family<int, String>((ref, countryName) async {
  final manager = ref.watch(favoriteManagerProvider);
  return manager.getFavoriteCount(countryName);
});



