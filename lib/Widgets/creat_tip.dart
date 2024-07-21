import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_app/Widgets/notify.dart';
import 'package:travel_app/databases/dataTheme.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class CreateTip extends StatefulWidget {
  const CreateTip({super.key});

  @override
  _CreateTipState createState() => _CreateTipState();
}

class _CreateTipState extends State<CreateTip> {
  final user = FirebaseAuth.instance.currentUser;
  final DatabaseReference TipRef =
      FirebaseDatabase.instance.ref().child("Tips");
  String documentId = "";
  String imageUrl = '';
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  String _notes = '';
  String _selectedTopic = '';
  List<String> imageUrls = [];
  final TextEditingController _newTopicController = TextEditingController();
  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String idUser = user!.uid;
      List likes = [];
      List comments = [];
      Map<dynamic, dynamic> dataToSend = {
        'id_name': idUser,
        'title': _title,
        'content': _content,
        'notes': _notes,
        'theme': _selectedTopic,
        'image': imageUrls,
        'datePublished': Timestamp.now().toDate().toIso8601String(),
        'like': likes,
        'comment': comments,
      };
      await TipRef.push().set(dataToSend).then((_) {
        showToast(message: 'Posting successfully');
      });
      Navigator.pushNamed(context, '/exp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Share tips with others'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter a title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter content'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
                onSaved: (value) {
                  _content = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter a note'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a note';
                  }
                  return null;
                },
                onSaved: (value) {
                  _notes = value!;
                },
              ),
              FutureBuilder<List<String>>(
                future: getAllThemes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error fetching themes'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No themes available'));
                  } else {
                    return Column(
                      children: [
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: _selectedTopic.isNotEmpty
                                ? _selectedTopic
                                : 'Choose a theme',
                          ),
                          items: [
                            ...snapshot.data!.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }),
                            const DropdownMenuItem<String>(
                              value: 'New Topic',
                              child: Text('Add new topic...'),
                            ),
                          ],
                          validator: (value) {
                            if (_selectedTopic.isEmpty) {
                              return 'Please select a theme';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              if (value == 'New Topic') {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Enter New Topic'),
                                      content: TextFormField(
                                        controller: _newTopicController,
                                        decoration: InputDecoration(
                                            labelText: 'Enter new topic'),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter a new topic';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          // No need for onSaved here
                                        },
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Save'),
                                          onPressed: () {
                                            if (_newTopicController
                                                .text.isNotEmpty) {
                                              setState(() {
                                                _selectedTopic =
                                                    _newTopicController.text;
                                              });
                                              Navigator.of(context).pop();
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                _selectedTopic = value!;
                              }
                            });
                          },
                          onSaved: (value) {
                            _selectedTopic = value ?? _selectedTopic;
                          },
                        ),
                      ],
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              Text("More illustrations of travel tips"),
              ElevatedButton(
                onPressed: () async {
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  if (file == null) return;

                  try {
                    var uuid = Uuid();
                    var randomName = uuid.v4();
                    Reference referenceRoot = FirebaseStorage.instance.ref();
                    Reference referenceDirImages = referenceRoot.child('img');
                    Reference referenceImageToUpload =
                        referenceDirImages.child(randomName);

                    await referenceImageToUpload.putFile(File(file.path));
                    String newImageUrl =
                        await referenceImageToUpload.getDownloadURL();

                    setState(() {
                      imageUrls.add(newImageUrl);
                    });
                  } catch (error) {
                    print('Error uploading image: $error');
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.image),
                    Text('Select a photo'),
                  ],
                ),
              ),
              if (imageUrls.isNotEmpty)
                Column(
                  children: [
                    for (String imageUrl in imageUrls)
                      Column(
                        children: [
                          Container(
                            height: 150,
                            child: Image.network(imageUrl),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  if (file == null) return;

                                  try {
                                    var uuid = Uuid();
                                    var randomName = uuid.v4();
                                    Reference referenceRoot =
                                        FirebaseStorage.instance.ref();
                                    Reference referenceDirImages =
                                        referenceRoot.child('img');
                                    Reference referenceImageToUpload =
                                        referenceDirImages.child(randomName);

                                    await referenceImageToUpload
                                        .putFile(File(file.path));
                                    String newImageUrl =
                                        await referenceImageToUpload
                                            .getDownloadURL();

                                    setState(() {
                                      imageUrls.remove(imageUrl);
                                      imageUrls.add(newImageUrl);
                                    });
                                  } catch (error) {
                                    print('Error uploading image: $error');
                                  }
                                },
                                child: Text('Change'),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    imageUrls.remove(imageUrl);
                                  });
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              Divider(),
              SizedBox(
                child: Text(
                    "Accepted image formats: PNG, JPEG, GIF, BMP, WebP, and TIFF."),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Upload'),
          onPressed: () {
            _saveForm();
          },
        ),
      ],
    );
  }
}
