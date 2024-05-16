import 'package:flutter/material.dart';
import 'package:mobile_app_demo/generals/colors.dart';
import 'package:mobile_app_demo/widgets/app_text.dart';
import 'package:mobile_app_demo/widgets/button.dart';

class WellcomePage extends StatefulWidget {
  const WellcomePage({super.key});

  @override
  State<WellcomePage> createState() => _WellcomePageState();
}

class _WellcomePageState extends State<WellcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (_, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("img/header.jpg"), fit: BoxFit.cover)),
              child: Container(
                margin: const EdgeInsets.only(top: 100, left: 50, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        AppLargeText(text: "Wellcome!"),
                        AppText(text: "Trave community"),
                        SizedBox(
                          height: 20,
                        ),
                        ResponsiveButton()
                      ],
                    ),
                    Column(
                        children: List.generate(3, (indexDots) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        width: 8,
                        height: index == indexDots ? 25 : 8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: index == indexDots
                                ? AppColors.button
                                : AppColors.button.withOpacity(0.3)),
                      );
                    }))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
