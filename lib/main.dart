import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Page/first_page.dart';
import 'package:travel_app/Page/forgot_pass_page.dart';
import 'package:travel_app/Page/home_page.dart';
import 'package:travel_app/Page/login_page.dart';
import 'package:travel_app/Page/sign_up_page.dart';
import 'package:travel_app/repositories/route_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        onGenerateRoute: generateRoute,
        // routes: {
        //   '/':(context) => Splast_Page(),
        //   '/login': (context) =>  Login_Page(),
        //   '/sign_up': (context) =>  Sign_up(),
        //   '/home_page': (context) => const Home_Page(),
        //   '/forgot_pass': (context) => const Forgot_pass()
        // },
      ),
    );
  }
}
