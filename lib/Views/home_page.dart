
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/Components/drawer_home.dart';
import 'package:travel_app/Views/country_list.dart';
import 'package:travel_app/Views/exp_page.dart';
import 'package:travel_app/Views/favorite_screen.dart';
import 'package:travel_app/Views/profile_page.dart';
import 'package:travel_app/Views/setting.dart';
import 'package:travel_app/Widgets/text_color.dart';
import 'package:travel_app/repositories/theme_notifier.dart';

class Home_Page extends ConsumerStatefulWidget {
  const Home_Page({super.key});

  @override
  ConsumerState<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends ConsumerState<Home_Page> {
  int selectedIndex = 0;

  static  List<Widget> pages = [
    const expPage(),
    CountryListScreen(),
    const FavoriteScreen(userId: ''),
    const ProfilePage(),
    const SettingPage()
  ];

  void onTapped(int index){
    if(index >=0 && index < pages.length){
      setState(() {
        selectedIndex = index;
      });
    }else{
      print('Invalid index: $index');
    }
  }
  @override
  Widget build(BuildContext context) {
    final isDarkmode = ref.watch(themeNotifierProvider) == ThemeMode.dark;
    return Scaffold(
      body: Builder(
        builder: (context){
          return pages[selectedIndex];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDarkmode? Colors.grey[700] : Colors.white70,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list_rounded),
            label: 'Country'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'
          )
        ],
        currentIndex: selectedIndex,
        unselectedItemColor: ColorList.grey800,
        selectedItemColor: Colors.blueAccent,
        onTap: onTapped,
      ),
    );
  }
}
