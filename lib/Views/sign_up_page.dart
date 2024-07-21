
import 'package:flutter/material.dart';
import 'package:travel_app/form/sign_up_form.dart';

class Sign_up extends StatelessWidget {
  const Sign_up({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/assets/image/dark_mountain1.jpg'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: SignUpForm(),
        ),
      ),
    );
  }
}
