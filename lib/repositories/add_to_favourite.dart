import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteController {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FavoriteController(this._firestore, this._auth);


  // Country favorite controller
  Future<void> addCountryToFavorites(
      String countryName, String iso2, String imageUrl, String details) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      final countryRef = _firestore.collection('countries').doc(countryName);
      final countryData = await countryRef.get();

      if (countryData.exists) {
        await countryRef.update({
          'favorites': FieldValue.increment(1),
        });
      } else {
        await countryRef.set({
          'name': countryName,
          'iso2': iso2,
          'imageUrl': imageUrl,
          'details': details,
          'favorites': 1,
        });
      }

      await _firestore.collection('users').doc(user.uid).collection('favorites').doc('favorites').collection('countries').add({
        'countryName': countryName,
        'iso2': iso2,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add to favorites: $e');
    }
  }

  Future<void> removeFromFavorite(String countryName) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      final countryRef = _firestore.collection('countries').doc(countryName);
      final countryData = await countryRef.get();

      if (countryData.exists) {
        final currentFavorites = countryData['favorites'] ?? 0;
        if (currentFavorites > 0) {
          await countryRef.update({
            'favorites': FieldValue.increment(-1),
          });
        }
      }

      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc('favorites')
          .collection('countries')
          .where('countryName', isEqualTo: countryName)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to remove from favorites: $e');
    }
  }

  Future<bool> isFavorite(String countryName) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc('favorites')
        .collection('countries')
        .where('countryName', isEqualTo: countryName)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<int> getFavoriteCount(String countryName) async {
    final doc = await _firestore.collection('countries').doc(countryName).get();
    return doc.exists ? doc['favorites'] ?? 0 : 0;
  }

  
  // City favorite controller
  Future<void> addCityToFavorites(
      String cityName, String imageUrl, String details) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      final countryRef = _firestore.collection('cities').doc(cityName);
      final countryData = await countryRef.get();

      if (countryData.exists) {
        await countryRef.update({
          'favorites': FieldValue.increment(1),
        });
      } else {
        await countryRef.set({
          'name': cityName,
          'imageUrl': imageUrl,
          'details': details,
          'favorites': 1,
        });
      }

      await _firestore.collection('users').doc(user.uid).collection('favorites').doc('favorites').collection('cities').add({
        'cityName': cityName,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add to favorites: $e');
    }
  }

  Future<void> removeCityFromFavorite(String cityName) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    try {
      final countryRef = _firestore.collection('cities').doc(cityName);
      final countryData = await countryRef.get();

      if (countryData.exists) {
        final currentFavorites = countryData['favorites'] ?? 0;
        if (currentFavorites > 0) {
          await countryRef.update({
            'favorites': FieldValue.increment(-1),
          });
        }
      }

      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc('favorites')
          .collection('cities')
          .where('cityName', isEqualTo: cityName)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Failed to remove from favorites: $e');
    }
  }

  Future<bool> isCityFavorite(String cityName) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc('favorites')
        .collection('cities')
        .where('cityName', isEqualTo: cityName)
        .get();

    return snapshot.docs.isNotEmpty;
  }

  Future<int> getCityFavoriteCount(String cityName) async {
    final doc = await _firestore.collection('cities').doc(cityName).get();
    return doc.exists ? doc['favorites'] ?? 0 : 0;
  }

}