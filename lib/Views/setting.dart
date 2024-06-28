import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/repositories/theme_notifier.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final themeNotifier = ref.watch(themeNotifierProvider.notifier);
    final isDarkMode = ref.watch(themeNotifierProvider) == ThemeModeState.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black 
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text('Theme', style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value){
                    themeNotifier.setTheme(value ? ThemeModeState.dark : ThemeModeState.light);
                  },
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}