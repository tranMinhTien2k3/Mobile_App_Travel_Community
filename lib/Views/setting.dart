import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Widgets/text_color.dart';
import 'package:travel_app/form/change_pass_form.dart';
import 'package:travel_app/repositories/auth_provider.dart';
import 'package:travel_app/repositories/theme_notifier.dart';
import 'package:travel_app/services/signout.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  void _showChangePasswordSheet(BuildContext context) {
    showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context){
      final double sheetHeight = MediaQuery.of(context).size.height * 0.41;

      return MediaQuery.removeViewInsets(
        context: context,
        removeBottom: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom
          ),
          child: Container(
            height: sheetHeight,
            child: ChangePassForm(),
          ),
        ),
      );
    }
  );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final themeNotifier = ref.watch(themeNotifierProvider.notifier);
    final isDarkMode = ref.watch(themeNotifierProvider) == ThemeModeState.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          // style: TextStyle(
          //   color: isDarkMode ? Colors.white : Colors.black 
          // ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text('Dark Mode'),//, style: TextStyle(color: isDarkMode ? ColorList.white70 : Colors.black),),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value){
                    themeNotifier.setTheme(value ? ThemeModeState.dark : ThemeModeState.light);
                  },
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Card(
              child: GestureDetector(
                child: ListTile(
                  title: Text('Log out', ),//style: TextStyle(color: isDarkMode? ColorList.white70 : Colors.black),),
                  trailing: Icon(Icons.logout, size: 30,) //color: isDarkMode ? ColorList.white70 : Colors.black,),
                ),
                onTap: () {
                  signOut(context, ref);
                  // ref.watch(authControllerProvider).signOut();
                },
              ),
            ),
            const SizedBox(height: 30,),
            GestureDetector(
              child: Card(
                child: ListTile(
                  title: Text('Change Password'),//style: TextStyle(color: isDarkMode ? ColorList.white70 : Colors.black),),
                  trailing: Icon(Icons.edit)//, color: isDarkMode ?  ColorList.white70 : Colors.black,),
                ),
              ),
              onTap: () => _showChangePasswordSheet(context),
            )
          ],
        )
      ),
    );
  }
}