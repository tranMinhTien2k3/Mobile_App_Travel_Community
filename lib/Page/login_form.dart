import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:travel_app/Page/home_page.dart';
import 'package:travel_app/Page/sign_up_page.dart';
import 'package:travel_app/Widgets/custom_button.dart';
import 'package:travel_app/Widgets/small_text.dart';
import 'package:travel_app/repositories/auth_provider.dart';

class SignIn_Form extends HookConsumerWidget {
  const SignIn_Form({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final email = useTextEditingController();
    final password = useTextEditingController();
    final obscureTextProvider = StateProvider<bool>((ref) => false);


    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: (user) {
          Navigator.pushNamed(context, '/home_page');
          // Navigate to any screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User Logged In'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        unauthenticated: (message) =>
            ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message!),
            behavior: SnackBarBehavior.floating,
          ),
        ),
      );
    });
    final _obscureText = ref.watch(obscureTextProvider);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
             controller: email,
             keyboardType: TextInputType.emailAddress,
             decoration: InputDecoration(
              suffixIcon: const Icon(
                Icons.email_rounded,
                size: 30,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              labelText: 'Email',
             ), 
             validator: (value){
              return (value == null || value.isEmpty) ?  'Please enter your email' : null;
             },
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(_obscureText? Icons.visibility : Icons.visibility_off),
                  onPressed: (){
                    ref.read(obscureTextProvider.notifier).update((_obscureText) => (!_obscureText));
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                labelText: 'Password'
              ),
              obscureText: _obscureText,
              validator: (value){
                return (value == null || value.isEmpty) ? 'Please enter your password' : null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 92,
                  child: Stack(
                    children:  [
                      SmallText(
                        text: 'Forgot password?',
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 24,
                        color: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}