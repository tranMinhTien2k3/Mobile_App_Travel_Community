import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:travel_app/databases/dataName.dart';
import 'package:travel_app/databases/databaseTip.dart';

class TipCard extends StatefulWidget {
  final String title;
  final String content;
  final String note;
  final String author;
  final String time;
  final List<String> imageUrl;
  final List likes;
  final List<String> comments;
  final String id;

  const TipCard(
      {super.key,
      required this.title,
      required this.author,
      required this.time,
      required this.imageUrl,
      required this.likes,
      required this.comments,
      required this.content,
      required this.note,
      required this.id});

  @override
  State<TipCard> createState() => _TipCardState();
}

class _TipCardState extends State<TipCard> {
  final user = FirebaseAuth.instance.currentUser;
  late String userId = "";
  @override
  Widget build(BuildContext context) {
    DateTime parsedDateTime = DateTime.parse(widget.time);
    userId = user!.uid;
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
                FutureBuilder<String>(
                  future: getName(widget.author),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        'Loading...', // Display a loading indicator or placeholder text
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
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
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      );
                    }
                  },
                ),
                // Text(
                //   'By ${widget.author}',
                //   style: TextStyle(
                //     fontStyle: FontStyle.italic,
                //   ),
                // ),
                Spacer(),
                Text(
                  timeago.format(parsedDateTime, locale: 'en'),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          (widget.imageUrl.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 300),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.9,
                      aspectRatio: 16 / 9,
                    ),
                    items: (widget.imageUrl).map((imageUrl) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Image.network(
                          imageUrl,
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "Tip: " + widget.content,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Note:' + widget.note,
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
                LikeButton(
                  isLiked: widget.likes.contains(userId) ? true : false,
                  onTap: (isLiked) async {
                    if (!isLiked) {
                      await addUserIdToLikes(widget.id, userId);
                    } else {
                      await removeUserIdFromLikes(widget.id, userId);
                    }
                    return !isLiked;
                  },
                  likeCount: widget.likes.length,
                  size: 30,
                  countPostion: CountPostion.right,
                ),
                Text(" Like"),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(FontAwesomeIcons.comment),
                  onPressed: () {
                    // Hành động khi nhấn nút bình luận
                  },
                ),
                Text('${widget.comments.length}'),
                Text(" Comment"),
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
