import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:travel_app/Widgets/notify.dart';
import 'package:travel_app/databases/dataName.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:travel_app/databases/databaseTip.dart';

class CommentTip extends StatefulWidget {
  final String post;
  final String id;
  final List comments;
  const CommentTip(
      {super.key,
      required this.id,
      required this.comments,
      required this.post});
  @override
  State<CommentTip> createState() => _CommentTipState();
}

class _CommentTipState extends State<CommentTip> {
  final TextEditingController commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> filedata = [];
  Widget commentChild(data) {
    if (data.isEmpty) {
      return Center(
        child: Text(
          "There are no comments yet. Be the first to give feedback on this experience.",
        ),
      );
    } else {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          DateTime parsedDateTime = DateTime.parse(data[index]['date']);
          return Padding(
              padding: EdgeInsets.all(8.0),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                tileColor: Colors.green[50],
                // leading: GestureDetector(
                //   onTap: () async {
                //     print("Comment Clicked");
                //   },
                //   child: Container(
                //     width: 50,
                //     height: 50,
                //     // Your leading content
                //   ),
                // ),
                title: Text(data[index]['message']),
                subtitle: Align(
                  alignment: Alignment.centerRight,
                  child: Column(children: [
                    FutureBuilder<String>(
                      future: getName(widget.comments[index]['id']),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                    SizedBox(
                        child: Text(
                          timeago.format(parsedDateTime, locale: 'en'),
                          style: TextStyle(fontSize: 12),
                        ),
                        height: 20.0),
                  ]),
                ),
              ));
        },
      );
    }
  }

  Future<void> loadComments() async {
    for (var i = 0; i < widget.comments.length; i++) {
      String name = await getName(widget.comments[i]['id']);
      String date = widget.comments[i]['date'];
      String message = widget.comments[i]['message'];

      filedata.add({
        'name': name,
        // 'pic': pic,
        'date': date,
        'message': message,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: loadComments(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AlertDialog(
            title: Text("Comment"),
            content: CommentBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
              labelText: 'write comment',
              errorText: 'Comment cannot be blank',
              withBorder: false,
              sendButtonMethod: () {
                if (formKey.currentState!.validate()) {
                  String comment = commentController.text;
                  setState(() {
                    Navigator.pushNamed(context, '/exp');
                    PostComment(widget.post, widget.id, comment);
                  });
                  commentController.clear();
                  FocusScope.of(context).unfocus();
                } else {
                  print("Not validated");
                }
              },
              formKey: formKey,
              commentController: commentController,
              backgroundColor: Color.fromARGB(255, 44, 214, 49),
              textColor: Colors.black,
              sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.black),
            ),
          );
        } else {
          return AlertDialog(
            title: Text("Comment"),
            content: CommentBox(
              child: commentChild(widget.comments),
              labelText: 'write comment',
              errorText: 'Comment cannot be blank',
              withBorder: false,
              sendButtonMethod: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    String comment = commentController.text;
                    PostComment(widget.post, widget.id, comment);
                    Navigator.pushNamed(context, '/exp');
                    showToast(message: 'Success Comments');
                  });
                  commentController.clear();
                  FocusScope.of(context).unfocus();
                } else {
                  print("Not validated");
                }
              },
              formKey: formKey,
              commentController: commentController,
              backgroundColor: Color.fromARGB(255, 44, 214, 49),
              textColor: Colors.black,
              sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.black),
            ),
          );
        }
      },
    );
  }
}
