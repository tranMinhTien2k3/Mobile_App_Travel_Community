// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:travel_app/models/city_firebase_model.dart';
// import 'package:travel_app/repositories/auth_provider.dart';

// final favoriteCitiesProvider = StateProvider<List<CityFirebase>>((ref) => []);
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// class RenewData{
//   final FirebaseFirestore _firestore;
//   final FirebaseAuth _auth;

//   RenewData(this._firestore, this._auth);

//   void loadFavoriteCity(WidgetRef ref) async{
//     final user = _auth.currentUser;
//     if(user != null){
//       try{
//         final snapshot = _firestore.collection('users').doc(user.uid).collection('favorites').doc('favorites').collection('cities').get();

//         ref.read(favoriteCitiesProvider.notifier).state = snapshot.docs.map()
//       }
//     }
//   }
// }