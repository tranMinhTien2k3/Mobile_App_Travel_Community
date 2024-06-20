import 'package:flutter/material.dart';
import 'package:travel_app/Views/cities_list.dart';
import 'package:travel_app/Views/city_detail.dart';
import 'package:travel_app/Views/country_detail.dart';
import 'package:travel_app/Views/first_page.dart';
import 'package:travel_app/Views/forgot_pass_page.dart';
import 'package:travel_app/Views/home_page.dart';
import 'package:travel_app/Views/login_page.dart';
import 'package:travel_app/Views/profile_page.dart';
import 'package:travel_app/Views/sign_up_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  WidgetBuilder builder;
  switch (settings.name) {
    case '/':
      builder = (BuildContext context) => Splast_Page();
      break;
    case '/login':
      builder = (BuildContext context) => Login_Page();
      break;
    case '/sign_up':
      builder = (BuildContext context) => Sign_up();
      break;
    case '/home_page':
      builder = (BuildContext context) => const Home_Page();
      break;
    case '/forgot_pass':
      builder = (BuildContext context) => const Forgot_pass();
      break;
    case '/profile':
      builder = (BuildContext context) => ProfilePage();
      break;
    case '/city_list':
      final countryName = settings.arguments as String;
      final iso2 = settings.arguments as String;
      builder = (BuildContext context) =>
          CityListScreen(name: countryName, iso2: iso2);
      break;
    case '/city_detail':
      builder = (BuildContext context) => CityDetailsScreen(city: '');
      break;
    case '/country_infor':
      builder = (BuildContext context) => CountryDetail(
            name: '',
            iso2: '',
          );
      break;

    default:
      throw Exception('Invalid route: ${settings.name}');
  }
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => builder(context),
      // transitionsBuilder: (context, animation, secondaryAnimation, child) {
      //   const begin = Offset(2.0, 0.0);
      //   const end = Offset.zero;
      //   const curve = Curves.easeInOut;

      //   var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      //   var offsetAnimation = animation.drive(tween);

      //   return SlideTransition(
      //     position: offsetAnimation,
      //     child: child,
      //   );
      // },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var opacityTween = Tween<double>(begin: 0.0, end: 1.0);
        return FadeTransition(
          opacity: opacityTween.animate(animation),
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 700));
}
