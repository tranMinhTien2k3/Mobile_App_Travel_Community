import 'package:firebase_database/firebase_database.dart';

final DatabaseReference userRef =
    FirebaseDatabase.instance.ref().child('Users');
bool containsLetter(String input) {
  RegExp letterRegExp = RegExp(r'[a-zA-Z]');
  return letterRegExp.hasMatch(input);
}

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
  if (name == " ") {
    return "Anonymous users";
  } else {
    return name;
  }
}

// Future<String> getAvt(String id_name) async {
//   String avt = "";
//   await userRef.child(id_name).once().then((event) {
//     if (event.snapshot.value != null) {
//       var userData = event.snapshot.value as Map<dynamic, dynamic>;
//       avt = userData['image'] ?? "";
//     }
//   });
//   if (avt == "") {
//     return 'lib/assets/image/user.jpg';
//   } else {
//     return avt;
//   }
// }
