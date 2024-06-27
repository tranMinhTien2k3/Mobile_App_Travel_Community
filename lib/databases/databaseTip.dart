import 'package:firebase_database/firebase_database.dart';

Future<void> removeUserIdFromLikes(String postId, String userId) async {
  DatabaseReference likesRef =
      FirebaseDatabase.instance.ref().child('Tips').child(postId).child('like');

  DataSnapshot snapshot = await likesRef.get();

  if (snapshot.exists) {
    List<dynamic> likesList = List.from(snapshot.value as Iterable);

    if (likesList.contains(userId)) {
      likesList.remove(userId);
      await likesRef.set(likesList);
    }
  }
}

Future<void> addUserIdToLikes(String postId, String userId) async {
  DatabaseReference likesRef =
      FirebaseDatabase.instance.ref().child('Tips').child(postId).child('like');

  DataSnapshot snapshot = await likesRef.get();

  if (snapshot.exists) {
    List<dynamic> likesList = List.from(snapshot.value as Iterable);

    if (!likesList.contains(userId)) {
      likesList.add(userId);
      await likesRef.set(likesList);
    }
  } else {
    await likesRef.set([userId]);
  }
}
