import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeState{light, dark}


class ThemeNotifier extends StateNotifier<ThemeModeState>{
  ThemeNotifier() : super(ThemeModeState.light){
    loadTheme();
  }

  void loadTheme() async{
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    state = isDarkMode ? ThemeModeState.dark : ThemeModeState.light;
  }

  void setTheme(ThemeModeState theme) async{
    state = theme;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', theme == ThemeMode.dark);
  }
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, ThemeModeState>((ref){
  return ThemeNotifier();
});