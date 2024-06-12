import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  final FontWeight? fontWeight;
  final bool softWrap; // Thêm thuộc tính softWrap vào SmallText
  final TextAlign textAlign;

  SmallText({
    Key? key,
    this.color = const Color(0x0ff9dad0),
    required this.text,
    this.size = 12,
    this.height = 1.2,
    this.fontWeight,
    this.softWrap = true, // Khởi tạo softWrap mặc định là true
    this.textAlign = TextAlign.start
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      softWrap: softWrap, // Sử dụng softWrap ở đây
      style: TextStyle(
        color: color,
        fontSize: size,
        height: height,
        fontWeight: fontWeight,
      ),
    );
  }
}
