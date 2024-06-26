import 'package:flutter/material.dart';

class CreateTip extends StatefulWidget {
  @override
  _CreateTipState createState() => _CreateTipState();
}

class _CreateTipState extends State<CreateTip> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  String _notes = '';
  String _selectedTopic = '';
  final List<String> _topics = ['theme 1', 'theme 2', 'theme 3'];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter a title'),
              onSaved: (value) {
                _title = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter a content'),
              onSaved: (value) {
                _content = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter a note'),
              onSaved: (value) {
                _notes = value!;
              },
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Choose a theme'),
              items: _topics.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTopic = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  // Hành động khi chọn ảnh
                },
                child: Row(children: [
                  Icon(Icons.image),
                  Text('Select a photo'),
                ])),
          ],
        ),
      ),
    );
  }
}

void showCreatePostDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Share tips with others'),
        content: CreateTip(),
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
              // Hành động khi lưu bài viết
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
