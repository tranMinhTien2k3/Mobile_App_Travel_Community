import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:like_button/like_button.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:travel_app/Components/custom_button.dart';
import 'package:travel_app/Views/cities_list.dart';
import 'package:travel_app/Widgets/big_text.dart';
import 'package:travel_app/Widgets/small_text.dart';
import 'package:travel_app/Widgets/text_color.dart';
import 'package:travel_app/repositories/api_provider.dart';


class CountryDetail extends ConsumerWidget {
  final String name;
  final String iso2;
  const CountryDetail({required this.name, required this.iso2});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidht = MediaQuery.of(context).size.width;

    final backgroundColor = ref.watch(colorProvider);
    final textColor = getTextColorForBackground(backgroundColor);

    final combinedDataFuture = Future.wait([
      ref.read(wikiProvider(name).future), // Đọc dữ liệu từ WikiProvider
      ref.read(imageProvider(name).future), // Đọc dữ liệu từ ImageProvider
    ]);

    

    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: combinedDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error loading data: ${snapshot.error}');
          } else {
            final List<dynamic> combinedData = snapshot.data!;

            final wikiData = combinedData[0] as Map<String, dynamic>;
            final imageUrl = combinedData[1] as String;

            
            return Stack(
              children: <Widget>[
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'lib/assets/image/dark_mountain.jpg',
                    width: screenWidht,
                    height: screenHeight*0.5,
                    fit: BoxFit.cover,
                  ),
                  // child: Image.network(
                  //   imageUrl,
                  //   width: screenWidht,
                  //   height: screenHeight * 0.45,
                  //   fit: BoxFit.cover,
                  // ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: SmallText(
                      text: '$name',
                      color: textColor,
                      size: 20,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.only(top: 45),
                    height: screenHeight * 0.55,
                    width: screenWidht,
                    decoration: BoxDecoration(
                      color: Colors.white, // Đặt màu nền của phần dưới
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: <Widget>[
                                SmallText(
                                  text: 'Introducing:',
                                  size: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                Divider(),
                                Container(
                                  width: screenWidht - 40,
                                  child: SmallText(
                                      text:  wikiData['extract'] != null ? wikiData['extract'] : 'No data available from Wikipedia',
                                      size: 18,
                                      softWrap: true,
                                      color: Colors.black,
                                    ),
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onHorizontalDragUpdate: (details) {
                                    // Kiểm tra nếu người dùng vuốt sang trái
                                    if (details.delta.dx < 0) {
                                      // Điều hướng sang trang mới
                                      Navigator.pushNamed(context, '/city_list', arguments: iso2);
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    width: screenWidht-100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(
                                        colors: [Color(0xFFA1C4FD), Color(0xFFC2E9FB)]
                                      )
                                    ),
                                    child: ElevatedButton(
                                      onPressed:() => Navigator.pushNamed(context, '/city_list', arguments: iso2),
                                      child: SmallText(
                                        text: '< Slide to see what city in $name',
                                        color: Colors.black87,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent
                                      )
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.37, // Đặt top ở giữa giữa
                  left: screenWidht * 0.05,
                  right: screenWidht * 0.05,
                  child: Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    height: 150, // Chiều cao của container
                    constraints: BoxConstraints(
                      maxWidth: screenWidht * 0.8
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), 
                        ),
                      ]
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Container(
                              width: screenWidht-150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BigText(
                                    text: '$name',
                                    size: 28,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  RatingStars(
                                    onValueChanged: (v){
                              
                                    },
                                    starBuilder: (index, color)=> Icon(
                                      Icons.star,
                                      color: color,
                                    ),
                                    starCount: 5,
                                    starSize: 20,
                                    valueLabelColor: const Color(0xff9b9b9b),
                                      valueLabelTextStyle: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12.0
                                    ),
                                    valueLabelRadius: 10,
                                    starSpacing: 2,
                                    // maxValueVisibility: true,
                                    // valueLabelVisibility: true,
                                    animationDuration: Duration(milliseconds: 1000),
                                    valueLabelPadding:
                                    const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                                    valueLabelMargin: const EdgeInsets.only(right: 8),
                                    starOffColor: const Color(0xffe7e8ea),
                                    starColor: Colors.yellow,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: LikeButton(
                              size: 40,
                              likeCount: 0,
                              countPostion: CountPostion.bottom,
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ),
              ],
            );
          }
        }
      ),
    );
  }
}