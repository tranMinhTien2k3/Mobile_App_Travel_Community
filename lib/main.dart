import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/Views/first_page.dart';
import 'package:travel_app/Views/forgot_pass_page.dart';
import 'package:travel_app/Views/home_page.dart';
import 'package:travel_app/Views/login_page.dart';
import 'package:travel_app/Views/sign_up_page.dart';
import 'package:travel_app/repositories/route_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travel_app/services/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
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
        initialRoute: '/home_page',
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
