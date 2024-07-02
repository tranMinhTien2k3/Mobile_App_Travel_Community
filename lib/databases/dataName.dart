import 'package:firebase_database/firebase_database.dart';

final DatabaseReference userRef =
    FirebaseDatabase.instance.ref().child('Users');

Future<String> getName(String id_name) async {
  String name = "";
  await userRef.child(id_name).once().then((event) {
    if (event.snapshot.value != null) {
      var userData = event.snapshot.value as Map<dynamic, dynamic>;
      String firstName = userData['first name'] ?? "";
      String lastName = userData['last name'] ?? "";
      name = firstName + " " + lastName;
    }
  });
  if (name == "") {
    return "Anonymous users";
  } else {
    return name;
  }
}
