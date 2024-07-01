import 'package:cloud_firestore/cloud_firestore.dart';

class CountryFirebase{
  final String name;
  final String iso2;

  CountryFirebase({
    required this.name,
    required this.iso2
  });

  factory CountryFirebase.fromFirestore(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CountryFirebase(
      name: data['countryName'] ?? '',
      iso2:  data['iso2'] ?? ''
    );
  }
}