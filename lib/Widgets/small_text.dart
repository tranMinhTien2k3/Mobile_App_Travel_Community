import 'package:flutter/cupertino.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  final FontWeight? fontWeight;
  final bool softWrap; // Thêm thuộc tính softWrap vào SmallText

  SmallText({
    Key? key,
    this.color = const Color(0x0ff9dad0),
    required this.text,
    this.size = 12,
    this.height = 1.2,
    this.fontWeight,
    this.softWrap = true, // Khởi tạo softWrap mặc định là true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
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
