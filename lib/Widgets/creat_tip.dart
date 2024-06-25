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
  final List<String> _topics = ['Chủ đề 1', 'Chủ đề 2', 'Chủ đề 3'];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Tiêu đề'),
              onSaved: (value) {
                _title = value!;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Nội dung'),
              onSaved: (value) {
                _content = value!;
              },
              maxLines: 3,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Ghi chú'),
              onSaved: (value) {
                _notes = value!;
              },
            ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Chủ đề'),
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
              child: Text('Chọn ảnh'),
            ),
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
        title: Text('Tạo bài viết mới'),
        content: CreateTip(),
        actions: <Widget>[
          TextButton(
            child: Text('Hủy'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Lưu'),
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
