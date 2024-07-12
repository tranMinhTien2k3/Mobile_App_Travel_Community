import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  BigText({
    Key? key,
    this.color,
    required this.text,
    this.size = 20,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start, // Giá trị mặc định của textAlign
    this.fontWeight = FontWeight.normal
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      textAlign: textAlign, // Chuyển giá trị textAlign xuống Text widget
      style: TextStyle(
        color: color,
        fontSize: size,
      ),
    );
  }
}

