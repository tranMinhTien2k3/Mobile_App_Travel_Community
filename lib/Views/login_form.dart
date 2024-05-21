// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// // ignore: depend_on_referenced_packages
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:travel_app/Components/text_form_field.dart';
// import 'package:travel_app/Views/home_page.dart';
// import 'package:travel_app/Views/sign_up_page.dart';
// import 'package:travel_app/Widgets/big_text.dart';
// import 'package:travel_app/Widgets/custom_button.dart';
// import 'package:travel_app/Widgets/small_text.dart';
// import 'package:travel_app/repositories/auth_provider.dart';


// final obscureTextProvider = StateProvider<bool>((ref) => true);
// final emailErrorProvider = StateProvider<bool>((ref) => false);
// final passwordErrorProvider = StateProvider<bool>((ref) => false);

// class Login_Form extends HookConsumerWidget {
//   const Login_Form({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

//     final email = useTextEditingController();
//     final password = useTextEditingController();
//     final emailError = ref.watch(emailErrorProvider);
//     final passwordError = ref.watch(passwordErrorProvider);
//     final formKey = useMemoized(() => GlobalKey<FormState>());

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
//     final _obscureText = ref.watch(obscureTextProvider);

//     return Padding(
//       padding: const EdgeInsets.all(24.0),
//       child: SingleChildScrollView(
//         child: Form(
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
          
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: BigText(
//                   text: 'Welcome back!',
//                   size: 45,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               TextFormField(
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 controller: email,
//                 keyboardType: TextInputType.emailAddress,
//                 style: TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   labelStyle: TextStyle(color: Colors.white),
//                   suffixIcon: const Icon(
//                     Icons.email_rounded,
//                     size: 30,
//                     color: Colors.white,
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide(color: Colors.white)
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide(color: Colors.white)
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide(color: Colors.white)
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide(color: Colors.white)
//                   ),
//                   labelText: 'Email',
//                   errorText: emailError ? 'Please enter your email' : null,
//                 ), 
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               TextFormField(
//                 autovalidateMode: AutovalidateMode.always,
//                 style: TextStyle(color: Colors.white),
//                 controller: password,
//                 decoration: InputDecoration(
//                   labelStyle: TextStyle(color: Colors.white),
//                   suffixIcon: IconButton(
//                     icon: Icon(_obscureText? Icons.visibility : Icons.visibility_off),
//                     color: Colors.white,
//                     onPressed: (){
//                       ref.read(obscureTextProvider.notifier).update((value) => (!value));
//                     },
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20.0),
//                   borderSide: BorderSide(color: Colors.white)
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide(color: const Color.fromARGB(255, 79, 76, 76))
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide(color: Colors.white)
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                     borderSide: BorderSide(color: Colors.white)
//                   ),
//                   labelText: 'Password',
//                   errorText: passwordError ? 'Please enter your password' : null,
//                 ),
//                 obscureText: _obscureText,
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               CustomButton(
//                 backgroundColor: Colors.white.withOpacity(0.3),
//                 isDisabled: false,
//                 title: 'Login',
//                 splashColor: Colors.white,
//                 loading: ref
//                     .watch(authNotifierProvider)
//                     .maybeWhen(orElse: () => false, loading: () => true),
//                 // onPressed: () async {
//                 //   ref.read(authNotifierProvider.notifier).login(
//                 //           email: email.text,
//                 //           password: password.text,
//                 //   );            
//                 // }
//                 onPressed: () async {
//                   final emailValid = email.text.isNotEmpty;
//                   final passwordValid = password.text.isNotEmpty;
          
//                   ref.read(emailErrorProvider.notifier).state = !emailValid;
//                   ref.read(passwordErrorProvider.notifier).state = !passwordValid;
          
//                   if (emailValid && passwordValid) {
//                     ref.read(authNotifierProvider.notifier).login(
//                       email: email.text,
//                       password: password.text,
//                     );
//                   }
//                 }
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 92,
//                     child: Stack(
//                       children:  [
//                         SmallText(
//                           text: 'Forgot password?',
//                           color: Colors.white,
//                         ),
//                         Icon(
//                           Icons.chevron_right,
//                           size: 24,
//                           color: Colors.white,
//                         )
//                       ],
//                     ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:travel_app/Widgets/custom_button.dart';
import 'package:travel_app/Widgets/big_text.dart';
import 'package:travel_app/Widgets/small_text.dart';
import 'package:travel_app/repositories/auth_provider.dart';

final obscureTextProvider = StateProvider<bool>((ref) => true);

class Login_Form extends HookConsumerWidget {
  const Login_Form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final obscureText = ref.watch(obscureTextProvider);

    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: (user) {
          Navigator.pushNamed(context, '/home_page');
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

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: BigText(
                  text: 'Welcome back!',
                  size: 45,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 50),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  suffixIcon: const Icon(
                    Icons.email_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: passwordController,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      ref.read(obscureTextProvider.notifier).state =
                          !obscureText;
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  labelText: 'Password',
                ),
                obscureText: obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              CustomButton(
                backgroundColor: Colors.white.withOpacity(0.3),
                isDisabled: false,
                title: 'Login',
                splashColor: Colors.white,
                loading: ref
                    .watch(authNotifierProvider)
                    .maybeWhen(orElse: () => false, loading: () => true),
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    ref.read(authNotifierProvider.notifier).login(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                  }
                },
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 92,
                    child: Stack(
                      children: [
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
      ),
    );
  }
}
