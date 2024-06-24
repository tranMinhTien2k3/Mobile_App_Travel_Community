import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/models/city_firebase_model.dart';
import 'package:travel_app/models/country.dart';
import 'package:travel_app/models/country_firebase_data_model.dart';



class GetFirebaseData{
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  GetFirebaseData(this._firestore, this._auth);


  Future<List<CountryFirebase>> getCountryFavorite(String userId) async{
    final user = _auth.currentUser;
    if(user == null) throw Exception('User not logged in');
    try{
      // final documentSnapshot = await _firestore.collection('users').doc(user.uid).get();
      // final data = documentSnapshot.data();
      // if(data == null){
      //   return [];
      // }
      // final List<dynamic> favorites = data['favorites'];
      // List<Country> favoritesCountries = favorites.map((favorites){
      //   return Country(
      //     name: favorites['countryName'] ?? '',
      //     iso2: favorites['iso2'] ?? ''
      //   );
      // }).toList();
      // return favoritesCountries;
      final querySnapshot = await _firestore.collection('users').doc(user.uid).collection('favorites').doc('favorites').collection('countries').get();
      List<CountryFirebase> favoritesCountries = querySnapshot.docs.map((doc){
        return CountryFirebase.fromFirestore(doc);
      }).toList();
      return favoritesCountries;
    } catch (e){
      return [];
    }
  }

  Future<List<CityFirebase>> getCityFavoriteList(String userId) async{
    final user = _auth.currentUser;
    if(user == null) throw Exception('User not logged in');
    try{
      final querySnapshot = await _firestore.collection('users').doc(user.uid).collection('favorites').doc('favorites').collection('cities').get();
      List<CityFirebase> favoritesCities = querySnapshot.docs.map((doc){
        return CityFirebase.fromFirestore(doc);
      }).toList();
      return favoritesCities;
    } catch (e){
      return [];
    }
  }
}