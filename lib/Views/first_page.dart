import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/Dimension/dimension.dart';
import 'package:travel_app/Widgets/small_text.dart';
import 'package:travel_app/convert/convert.dart';
import 'package:travel_app/repositories/auth_provider.dart';

class Splast_Page extends HookConsumerWidget {
  Splast_Page({Key? key});

  List<String> imageList = [
    'lib/assets/image/mountain.jpg',
    'lib/assets/image/lake.jpg',
    // 'lib/assets/image/lake2.jpg',
    'lib/assets/image/mountain2.jpg',
    'lib/assets/image/image.jpg'
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: (user) {
          Navigator.pushNamed(context, '/home_page');
          // Navigate to any screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User Logged In'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        unauthenticated: (message) =>
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message!),
            behavior: SnackBarBehavior.floating,
          ),
        ),
      );
    });

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            viewportFraction: 1.0,
            aspectRatio: MediaQuery.of(context).size.width / MediaQuery.of(context).size.height,
          ),
          items: imageList.map((imageUrl) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }).toList(),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            SizeConfig().init(constraints);
            return Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Share',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Converts.c56,
                                decoration: TextDecoration.none // Size của text không cần sử dụng từ Convert
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            DefaultTextStyle(
                              style:TextStyle(
                                color: Colors.white,
                                fontSize: 48, // Size của text không cần sử dụng từ Convert
                              ),
                              child: AnimatedTextKit(
                                repeatForever: true,
                                animatedTexts: [
                                  FadeAnimatedText('your travels, inspire the world', duration: Duration(milliseconds: 3000)),
                                  FadeAnimatedText('the joy of travel, one story at a time', duration: Duration(milliseconds: 2000)),
                                  FadeAnimatedText('your adventures, ignite wanderlust', duration: Duration(milliseconds: 2000)),
                                  FadeAnimatedText('your journeys, create memories', duration: Duration(milliseconds: 2000))
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.transparent.withOpacity(0.2),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                runSpacing: 12,
                                spacing: 20,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height * 0.08,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent.withOpacity(0.2),                                        
                                      ),
                                      onPressed: (){
                                        Navigator.pushNamed(
                                          context,
                                          '/login'
                                        );
                                      },
                                      child: SmallText(
                                        text: 'Login now',
                                        size: 24,
                                        color: Colors.white,
                                      )
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height * 0.08,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white24.withOpacity(0.2),
                                        padding: EdgeInsets.all(15),
                                      ),
                                      onPressed: (){
                                        Navigator.pushNamed(context, '/sign_up');
                                      },
                                      child: SmallText(
                                        text: 'Join now',
                                        size: 24,
                                        color: Colors.white,
                                      )
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                          ],
                        )
                      ),
                    ),
                  )
                )
              ]
            );
          },
        ),
      ]
    );
  }
}
