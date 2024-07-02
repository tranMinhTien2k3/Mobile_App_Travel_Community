
import 'package:cloud_firestore/cloud_firestore.dart';

class CityFirebase{
  final String name;

  CityFirebase({
    required this.name
  });

  factory CityFirebase.fromFirestore(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CityFirebase(
      name: data['cityName'] ?? '',
    );
  }

}