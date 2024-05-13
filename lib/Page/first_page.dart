import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_app/Dimension/dimension.dart';
import 'package:travel_app/convert/convert.dart';

class Splast_Page extends StatelessWidget {
  const Splast_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(context, contrast){
        SizeConfig().init(contrast);
        return Scaffold(
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/image/mountain.jpg'),
                fit: BoxFit.cover
              )
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight*0.2,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.02),
                        alignment: Alignment.topLeft,
                        width: SizeConfig.screenWidth * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Share',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Converts.c56
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight*0.01,
                            ),
                            DefaultTextStyle(
                              style:TextStyle(
                                color: Colors.white,
                                fontSize: Converts.c48
                              ),
                              child: AnimatedTextKit(
                                animatedTexts: [
                                  TyperAnimatedText('your travels, inspire the world', speed: Duration(milliseconds: 100)),
                                  TyperAnimatedText('the joy of travel, one story at a time', speed: Duration(milliseconds: 100))
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
                        height: SizeConfig.screenHeight * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.transparent.withOpacity(0.2),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: SizeConfig.screenHeight*0.03,
                            ),
                            Container(
                              width: SizeConfig.screenWidth,
                              alignment: Alignment.center,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                runSpacing: 12,
                                spacing: 20,
                                children: <Widget>[
                                  Container(
                                    width: SizeConfig.screenWidth * 0.4,
                                    height: SizeConfig.screenHeight *0.08,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueAccent.withOpacity(0.2),                                        
                                      ),
                                      onPressed: (){},
                                      child: Text(
                                        'Login now',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Converts.c24
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.4,
                                    height: SizeConfig.screenHeight *0.08,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white24.withOpacity(0.2),
                                        padding: EdgeInsets.all(15)
                                      ),
                                      onPressed: (){},
                                      child: Text(
                                        'Join now',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Converts.c24
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                            Text(
                              'Or login with',
                              style: TextStyle(
                                fontSize: Converts.c20,
                                color: Colors.white
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.02,
                            ),
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              runSpacing: 12,
                              spacing: 20,
                              children: <Widget>[
                                Container(
                                  height: SizeConfig.screenHeight * 0.07,
                                  width: SizeConfig.screenWidth * 0.16,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: IconButton(
                                    onPressed: (){}, 
                                    icon: const FaIcon(
                                      FontAwesomeIcons.google,
                                      size: 40,
                                      color: Colors.white,
                                    )
                                  ),
                                ),
                                Container(
                                  height: SizeConfig.screenHeight * 0.07,
                                  width: SizeConfig.screenWidth * 0.16,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: IconButton(
                                    onPressed: (){}, 
                                    icon: const FaIcon(
                                      FontAwesomeIcons.facebookF,
                                      size: 40,
                                      color: Colors.white,
                                    )
                                  ),
                                )    
                              ],
                            )
                          ],
                        )
                      ),
                    ),
                  )
                )
              ]
            ),
          ),
        );
      }
    );
  }
}