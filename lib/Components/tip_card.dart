import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TipCard extends StatefulWidget {
  final String title;
  final String content;
  final String note;
  final String author;
  final String time;
  final String imageUrl;
  final int likes;
  final int comments;

  const TipCard(
      {super.key,
      required this.title,
      required this.author,
      required this.time,
      required this.imageUrl,
      required this.likes,
      required this.comments,
      required this.content,
      required this.note});

  @override
  State<TipCard> createState() => _TipCardState();
}

class _TipCardState extends State<TipCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  'By ${widget.author}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Spacer(),
                Text(widget.time),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Image.network(
                  widget.imageUrl,
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.content,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Note:' + widget.content,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.heart),
                  onPressed: () {
                    // Hành động khi nhấn nút tim
                  },
                ),
                Text('${widget.likes}'),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(FontAwesomeIcons.comment),
                  onPressed: () {
                    // Hành động khi nhấn nút bình luận
                  },
                ),
                Text('${widget.comments}'),
                Spacer(),
                IconButton(
                  icon: Icon(FontAwesomeIcons.share),
                  onPressed: () {
                    // Hành động khi nhấn nút chia sẻ
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
