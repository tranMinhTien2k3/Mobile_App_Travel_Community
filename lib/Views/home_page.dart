import 'package:flutter/material.dart';
import 'package:travel_app/Components/bottom_nav.dart';
import 'package:travel_app/Components/drawer_home.dart';
import 'package:travel_app/Views/country_list.dart';
import 'package:travel_app/Views/exp_page.dart';
import 'package:travel_app/Views/favorite_screen.dart';
import 'package:travel_app/Views/setting.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerHome(),
      body: expPage() ,
    );
  }
}
