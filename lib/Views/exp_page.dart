import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/Widgets/creat_tip.dart';
import 'package:travel_app/databases/dataName.dart';

class expPage extends StatefulWidget {
  const expPage({super.key});

  @override
  State<expPage> createState() => _expPageState();
}

class _expPageState extends State<expPage> {
  final DatabaseReference usersRef =
      FirebaseDatabase.instance.ref().child("Users");
  final DatabaseReference tipsRef =
      FirebaseDatabase.instance.ref().child("Tips");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Tips"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder<DatabaseEvent>(
        stream: tipsRef.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return Center(child: Text('No data available'));
          }

          final Map<dynamic, dynamic>? tipsMap =
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>?;

          if (tipsMap == null) {
            return Center(child: Text('Data format error'));
          }

          final List<Map<dynamic, dynamic>> tips = [];

          tipsMap.forEach((key, value) {
            if (value is Map<dynamic, dynamic>) {
              Map<String, dynamic> tip = value.cast<String, dynamic>();
              tip['id'] = key; // Thêm ID vào dữ liệu của tip
              tips.add(tip);
            }
          });

          return ListView.builder(
            itemCount: tips.length,
            itemBuilder: (context, index) {
              List<String> img = [];
              if (tips[index]['image'] != null &&
                  tips[index]['image'] is List<dynamic>) {
                img = tips[index]['image'].cast<String>();
              }

              List like = [];
              if (tips[index]['like'] != null &&
                  tips[index]['like'] is List<dynamic>) {
                like = tips[index]['like'].cast<String>();
              }
              List comment = [];
              if (tips[index]['comments'] != null) {
                comment = tips[index]['comments'];
              }
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/exp_detail', arguments: {
                      'title': tips[index]['title'],
                      'content': tips[index]['content'],
                      'note': tips[index]['notes'],
                      'author': tips[index]['id_name'],
                      'time': tips[index]['datePublished'],
                      'imageUrl': img,
                      'likes': like,
                      'comments': comment,
                      'id': tips[index]['id'],
                    });
                  },
                  title: Text(tips[index]['title']),
                  subtitle: FutureBuilder<String>(
                    future: getName(tips[index]['id_name']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          'Loading...',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.red,
                          ),
                        );
                      } else {
                        String authorName = snapshot.data ?? 'Unknown';
                        return Text(
                          'By $authorName',
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
              // TipCard(
              //
              // );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CreateTip();
              });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
