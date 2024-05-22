
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// // ignore: depend_on_referenced_packages
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:travel_app/Views/home_page.dart';
// import 'package:travel_app/Views/sign_up_page.dart';
// import 'package:travel_app/Widgets/custom_button.dart';
// import 'package:travel_app/repositories/auth_provider.dart';

// class Login_Page extends HookConsumerWidget {
//   const Login_Page({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final email = useTextEditingController();
//     final password = useTextEditingController();

//     ref.listen(authNotifierProvider, (previous, next) {
//       next.maybeWhen(
//         orElse: () => null,
//         authenticated: (user) {
//           Navigator.pushNamed(context, '/home_page');
//           // Navigate to any screen
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('User Logged In'),
//               behavior: SnackBarBehavior.floating,
//             ),
//           );
//         },
//         unauthenticated: (message) =>
//             ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(message!),
//             behavior: SnackBarBehavior.floating,
//           ),
//         ),
//       );
//     });

//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 controller: email,
//                 decoration: const InputDecoration(hintText: 'Email'),
//               ),
//               const SizedBox(height: 30),
//               TextField(
//                 controller: password,
//                 obscureText: true,
//                 decoration: const InputDecoration(hintText: 'Password'),
//               ),
//               const SizedBox(height: 40),
//               Center(
//                 child: CustomButton(
//                   isDisabled: false,
//                   title: 'Sign in',
//                   loading: ref
//                       .watch(authNotifierProvider)
//                       .maybeWhen(orElse: () => false, loading: () => true),
//                   onPressed: () async {
//                     ref.read(authNotifierProvider.notifier).login(
//                             email: email.text,
//                             password: password.text,
//                     );            
//                   }
//                 ),
//               ),
//               const SizedBox(height: 40),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Don\'t have account? '),
//                   TextButton(
//                     onPressed: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const Sign_up(),
//                       ),
//                     ),
//                     child: const Text('Signup'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/Views/login_form.dart';
import 'package:travel_app/Widgets/big_text.dart';

class Login_Page extends HookConsumerWidget {
  const Login_Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/image/dark_mountain.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: Center(
          child: Login_Form(),
        ),
      )
    );
  }
}