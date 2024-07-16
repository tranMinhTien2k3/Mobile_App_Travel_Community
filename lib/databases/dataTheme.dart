import 'package:firebase_database/firebase_database.dart';

Future<List<String>> getAllThemes() async {
  DatabaseReference tipsRef = FirebaseDatabase.instance.ref().child('Tips');
  Set<String> allThemes = {};

  DatabaseEvent tipsSnapshot = await tipsRef.once();

  Map<dynamic, dynamic>? postIdMap = tipsSnapshot.snapshot.value as Map?;
  if (postIdMap != null) {
    for (var key in postIdMap.keys) {
      DatabaseEvent themeSnapshot =
          await tipsRef.child(key).child('theme').once();
      if (themeSnapshot.snapshot.value != null) {
        allThemes.add(themeSnapshot.snapshot.value.toString());
      }
    }
  }

  return allThemes.toList();
}
