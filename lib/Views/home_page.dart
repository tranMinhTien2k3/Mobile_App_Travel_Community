import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_app/Components/drawer_home.dart';
import 'package:travel_app/Views/country_list.dart';
import 'package:travel_app/repositories/get_api.dart';

class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerHome(),
      body:CountryListScreen() ,
    );
  }
}
