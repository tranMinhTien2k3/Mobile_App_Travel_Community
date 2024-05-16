import 'package:flutter/material.dart';
import 'package:mobile_app_demo/generals/colors.dart';

class ResponsiveButton extends StatelessWidget {
  const ResponsiveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 90,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.button),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.navigate_next),
          ],
        ));
  }
}
