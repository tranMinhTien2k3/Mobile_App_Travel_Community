import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  double size;
  final Color color;
  final String text;
  AppText(
      {Key? key,
      this.size = 16,
      this.color = Colors.black54,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
      ),
    );
  }
}

class AppLargeText extends StatelessWidget {
  double size;
  final Color color;
  final String text;
  AppLargeText(
      {Key? key, this.size = 30, this.color = Colors.black, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
