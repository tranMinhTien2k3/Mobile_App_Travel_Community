import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class GetFirebaseData{
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  GetFirebaseData(this._firestore, this._auth);


  Future<List<String>> getCountryFavorite(String userId) async{
    final user = _auth.currentUser;
    if(user == null) throw Exception('User not logged in');
    try{
      final documentSnapshot = await _firestore.collection('users').doc('userId').get();
      final data = documentSnapshot.data();
      if(data == null){
        return [];
      }
      return List<String>.from(data['favorites']) ?? [];
    } catch (e){
      return [];
    }
  }

  Future<List<String>> getCityFavoriteList(String userId) async{
    final user = _auth.currentUser;
    if(user == null) throw Exception('User not logged in');
    try{
      final documentSnapshot = await _firestore.collection('users').doc('userId').get();
      final data = documentSnapshot.data();
      if(data == null){
        return [];
      }
      return List<String>.from(data['favorites']) ?? [];
    } catch (e){
      return [];
    }
  }
}