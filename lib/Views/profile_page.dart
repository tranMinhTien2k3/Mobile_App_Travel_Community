import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  final DatabaseReference usersRef =
      FirebaseDatabase.instance.ref().child("Users");
  String documentId = "";
  String imageUrl = '';

  bool _isLoggedIn() {
    if (user != null) {
      documentId = user!.uid;
      return true;
    } else
      return false;
  }

  Future<void> editProfile(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 220, 255, 231),
        title: Text("Edit: " + field),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              hintText: "Enter new $field",
              hintStyle: TextStyle(
                  color: Color.fromARGB(57, 45, 45, 109),
                  fontWeight: FontWeight.bold)),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('cancel')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(newValue);
              },
              child: Text('Save'))
        ],
      ),
    );
    if (newValue.trim().isNotEmpty) {
      await usersRef.child(documentId).update({field: newValue});
      Navigator.pushNamed(context, '/profile');
    }
  }

  Widget itemProfile(
      String title, String subtitle, String n, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: Colors.deepOrange.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: IconButton(
          icon: Icon(Icons.settings),
          color: Colors.grey.shade400,
          onPressed: () {
            editProfile(n);
          },
        ),
        tileColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Colors.green[200],
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Thông tin cá nhân"),
                Text(
                  _isLoggedIn() ? user!.email! : "Please Sign In",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            )),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: FutureBuilder<DatabaseEvent>(
                future: usersRef.child(documentId).once(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    Map<String, dynamic>? data =
                        snapshot.data?.snapshot.value as Map<String, dynamic>?;
                    if (data == null || data.isEmpty) {
                      usersRef.child(documentId).set({
                        'first name': '',
                        'last name': '',
                        'phone': '',
                        'address': '',
                        'age': '',
                        'email': user?.email,
                      });

                      data = {
                        'first name': '',
                        'last name': '',
                        'phone': '',
                        'address': '',
                        'age': '',
                        'email': user?.email,
                      };
                    }
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          trailing: IconButton(
                              onPressed: () async {
                                ImagePicker imagePicker = ImagePicker();
                                XFile? file = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                print('${file?.path}');

                                if (file == null) return;
                                var uuid = Uuid();
                                var randomName = uuid.v4();
                                Reference referenceRoot =
                                    FirebaseStorage.instance.ref();
                                Reference referenceDirImages =
                                    referenceRoot.child('avt');
                                Reference referenceImageToUpload =
                                    referenceDirImages.child(randomName);

                                try {
                                  await referenceImageToUpload
                                      .putFile(File(file.path));
                                  imageUrl = await referenceImageToUpload
                                      .getDownloadURL();
                                } catch (error) {}
                                usersRef.child(documentId).update({
                                  'image': imageUrl,
                                });
                              },
                              icon: Icon(Icons.camera_alt)),
                          tileColor: Colors.white,
                        ),
                        (data['image'] != null)
                            ? CircleAvatar(
                                radius: 80.0,
                                backgroundImage: NetworkImage(data['image']),
                                backgroundColor: Colors.transparent,
                              )
                            : CircleAvatar(
                                radius: 80.0,
                                backgroundImage:
                                    AssetImage('assets/img/user.png'),
                              ),
                        const SizedBox(height: 20),
                        itemProfile('First Name', '${data['first name']}',
                            'first name', Icons.badge_outlined),
                        const SizedBox(height: 10),
                        itemProfile('Last Name', '${data['last name']}',
                            'last name', Icons.badge),
                        const SizedBox(height: 10),
                        itemProfile(
                            'Phone', '${data['phone']}', 'phone', Icons.phone),
                        const SizedBox(height: 10),
                        itemProfile('Address', '${data['address']}', 'address',
                            Icons.place),
                        const SizedBox(height: 10),
                        itemProfile('Age', '${data['age']}', 'age', Icons.cake),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }))));
  }
}
