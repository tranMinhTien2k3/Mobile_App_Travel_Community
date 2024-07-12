import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/Widgets/text_color.dart';
import 'package:travel_app/repositories/theme_notifier.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;
  final DatabaseReference usersRef =
      FirebaseDatabase.instance.ref().child("Users");
  String documentId = "";
  String imageUrl = '';

  Future<void> editProfile(String field) async {
    String newValue = "";
    final isDarkMode = ref.watch(themeNotifierProvider) == ThemeMode.dark;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDarkMode ? ColorList.grey800 : ColorList.white70,
        title: Text("Edit: " + field),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: isDarkMode ? ColorList.white70 : Colors.black, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              hintText: "Enter new $field",
              hintStyle: TextStyle(
                  color: isDarkMode ? ColorList.white70 : Colors.grey,
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
              child: Text('Cancel', style: TextStyle(color: Colors.redAccent),)),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(newValue);
              },
              child: Text('Save', style: TextStyle(color: Colors.blue),))
        ],
      ),
    );
    if (newValue.trim().isNotEmpty) {
      await usersRef.child(documentId).update({field: newValue});
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeNotifierProvider) == ThemeMode.dark;
    documentId = user!.uid;

    Widget itemProfile(
      String title, String subtitle, String n, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? ColorList.grey800 : Colors.white,
          borderRadius: isDarkMode? BorderRadius.circular(20) : BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                color: isDarkMode? Colors.white70.withOpacity(0.2) : Colors.deepOrange.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 10)
          ]),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          color: Colors.grey.shade400,
          onPressed: () {
            editProfile(n);
          },
        ),
        tileColor: Colors.white,
      ),
    );
  }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Colors.green[200],
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Thông tin cá nhân"),
                Text(
                  user!.email!,
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
                    } else if (!snapshot.hasData ||
                        snapshot.data!.snapshot.value == null) {
                      usersRef.child(documentId).set({
                        'first name': '',
                        'last name': '',
                        'phone': '',
                        'address': '',
                        'age': '',
                        'email': user?.email,
                      });
                    }
                    Map<dynamic, dynamic>? data =
                        snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
                    Map<String, dynamic> convertedData =
                        Map<String, dynamic>.from(data);
                    if (data.isEmpty) {
                      convertedData = {
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

                                if (file == null) return;
                                var uuid = const Uuid();
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
                              icon: Icon(Icons.image)),
                          tileColor: isDarkMode ? ColorList.white70 : Colors.black,
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
                                    AssetImage('lib/assets/image/user.jpg'),
                              ),
                        const SizedBox(height: 20),
                        itemProfile(
                            'First Name',
                            '${convertedData['first name']}',
                            'first name',
                            Icons.badge_outlined),
                        const SizedBox(height: 10),
                        itemProfile(
                            'Last Name',
                            '${convertedData['last name']}',
                            'last name',
                            Icons.badge),
                        const SizedBox(height: 10),
                        itemProfile('Phone', '${convertedData['phone']}',
                            'phone', Icons.phone),
                        const SizedBox(height: 10),
                        itemProfile('Address', '${convertedData['address']}',
                            'address', Icons.place),
                        const SizedBox(height: 10),
                        itemProfile('Age', '${convertedData['age']}', 'age',
                            Icons.cake),
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
