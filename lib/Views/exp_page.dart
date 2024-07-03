import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/Components/drawer_home.dart';
import 'package:travel_app/Components/tip_card.dart';
import 'package:travel_app/Widgets/creat_tip.dart';

class expPage extends StatefulWidget {
  const expPage({super.key});

  @override
  State<expPage> createState() => _expPageState();

  
}

class _expPageState extends State<expPage> {
  final user = FirebaseAuth.instance.currentUser;
  final DatabaseReference usersRef =
      FirebaseDatabase.instance.ref().child("Users");
  final DatabaseReference tipsRef =
      FirebaseDatabase.instance.ref().child("Tips");

  Map<String, dynamic> userData = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData(){
    usersRef.once().then((DatabaseEvent event){
      final DataSnapshot snapshot =event.snapshot;

      if(snapshot.exists && snapshot.value != null){
        setState((){
          userData = Map<String, dynamic>.from(snapshot.value as Map);
        });
      }
    }).catchError((error){
      print('Error: $error');
    });
  }

  String getAuthorName(String userId){
    if(userData.containsKey(userId)){
      Map<String, dynamic> user = userData[userId];
      if(user.containsKey('name') && user['name'] != null && user['name'].toString().isNotEmpty){
        return user['name'];
      }else{
        return user['email'];
      }
    }
    return 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(icon: Icon(Icons.menu), onPressed: () => DrawerHome.new,),
      //   title: Text("Travel Tips"),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.filter_list),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
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
              // return ListTile(
              //   title: Text( ?? ''),
              //   subtitle: Text(tips[index]['content'] ?? ''),
              // );
              
              int comment = 3;
              final authorId = tips[index]['id_name'];
              String author = 'Name';
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
              return TipCard(
                title: tips[index]['title'],
                content: tips[index]['content'],
                note: tips[index]['notes'],
                author: author,
                time: tips[index]['datePublished'],
                imageUrl: img,
                likes: like,
                comments: comment,
                id: tips[index]['id'],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CreateTip();
              });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
