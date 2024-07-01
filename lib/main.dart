import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_app/repositories/route_transition.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travel_app/repositories/theme_notifier.dart';
import 'package:travel_app/services/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final initialTheme = await _loadInitialTheme();
  runApp(
    ProviderScope(
      overrides: [
        themeNotifierProvider.overrideWith((ref) => ThemeNotifier()..setTheme(initialTheme))
      ],
      child: MyApp(),
    ),
  );
}

Future<ThemeModeState> _loadInitialTheme() async{
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  return isDarkMode ? ThemeModeState.dark : ThemeModeState.light;
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: themeMode == ThemeModeState.light ? ThemeMode.light : ThemeMode.dark,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
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
