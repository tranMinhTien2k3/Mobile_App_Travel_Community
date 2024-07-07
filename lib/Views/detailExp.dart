import 'package:flutter/material.dart';
import 'package:travel_app/Components/tip_card.dart';

class DetailExp extends StatefulWidget {
  final String title;
  final String content;
  final String note;
  final String author;
  final String time;
  final List<String> imageUrl;
  final List likes;
  final List comments;
  final String id;
  const DetailExp(
      {super.key,
      required this.title,
      required this.content,
      required this.note,
      required this.author,
      required this.time,
      required this.imageUrl,
      required this.likes,
      required this.comments,
      required this.id});

  @override
  State<DetailExp> createState() => _DetailExpState();
}

class _DetailExpState extends State<DetailExp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Tips"),
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        child: TipCard(
          title: widget.title,
          time: widget.time,
          author: widget.author,
          imageUrl: widget.imageUrl,
          likes: widget.likes,
          comments: widget.comments,
          content: widget.content,
          note: widget.note,
          id: widget.id,
        ),
      ),
    );
  }
}
