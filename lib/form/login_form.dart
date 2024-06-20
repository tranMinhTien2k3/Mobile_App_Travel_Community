import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:travel_app/Components/password_form_field.dart';
import 'package:travel_app/Components/text_form_field.dart';
import 'package:travel_app/Components/custom_button.dart';
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
    final focusNode = useFocusNode();

    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: (user) {
          Navigator.pushNamed(context, '/home_page'); // dieu huong den trang chu
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
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
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
                const SizedBox(height: 50),
                CustomEmailTextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'Email',
                  focusNode: focusNode,
                  icon: const Icon(
                    Icons.email_rounded,
                    color: Colors.white,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                CustomPasswordFormField(
                  controller: passwordController,
                  labelText: 'Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/forgot_pass'),
                      child: SmallText(
                        text: 'Forgot password?',
                        color: Colors.white,
                        size: 16,
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  backgroundColor: Colors.white.withOpacity(0.6),
                  isDisabled: false,
                  title: 'Login',
                  splashColor: Colors.white,
                  titleColor: Colors.black,
                  width: 200,
                  loading: ref
                      .watch(authNotifierProvider)
                      .maybeWhen(orElse: () => false, loading: () => true),
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      ref.read(authNotifierProvider.notifier).login(   // dang nhap voi email va mat khau
                            email: emailController.text,
                            password: passwordController.text,
                          );
                    }
                  },
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/sign_up'),  // dieu huong den trang dang ky
                  child: SmallText(
                    text: 'To Register >',
                    color: Colors.white,
                    size: 16,
                  )
                ),
                SmallText(
                  text: 'Or continue with',
                  color: const Color.fromARGB(219, 255, 255, 255),
                  size: 16,
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 12,
                  spacing: 20,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.16,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                          onPressed: () async {
                            ref
                                .read(authNotifierProvider.notifier)
                                .continueWithGoogle();  // dang nhap voi tai khoan Google
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                            size: 40,
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.16,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                          onPressed: () async {
                            ref
                                .read(authNotifierProvider.notifier)
                                .continueWithFacebook();  // dang nhap voi tai khoan Facebook
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.facebookF,
                            size: 40,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
