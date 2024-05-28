import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/Components/custom_button.dart';
import 'package:travel_app/Components/password_form_field.dart';
import 'package:travel_app/Components/text_form_field.dart';
import 'package:travel_app/Widgets/small_text.dart';
import 'package:travel_app/form/login_form.dart';
import 'package:travel_app/Widgets/big_text.dart';
import 'package:travel_app/repositories/auth_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SignUpForm extends HookConsumerWidget {
  const SignUpForm({super.key});

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty || !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  String? validatePasswordMatch(String? value, String? otherValue) {
    if (value != otherValue) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final rePasswordController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final obscureText = ref.watch(obscureTextProvider);
    final passwordFocusNode = useFocusNode();
    final focusNode = useFocusNode();
    final showPasswordValidator = useState(false);

    useEffect(() {
      void listener() {
        showPasswordValidator.value = passwordFocusNode.hasFocus;
      }

      passwordFocusNode.addListener(listener);
      return () => passwordFocusNode.removeListener(listener);
    }, [passwordFocusNode]);

    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: (user) {
          Navigator.pushNamed(context, '/login');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Create accont success!'),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BigText(
                  text: 'Welcome',
                  size: 50,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 40,
                ),
                CustomEmailTextFormField(
                  controller: emailController,
                  labelText: 'Email',
                  focusNode: focusNode,
                  icon: Icon(
                    Icons.email_rounded,
                    color: Colors.white,
                  ),
                  validator: validateEmail,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomPasswordFormField(
                  controller: passwordController,
                  labelText: 'Password',
                  focusNode: passwordFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                if (showPasswordValidator.value)
                  FlutterPwValidator(
                      width: 400,
                      height: 150,
                      minLength: 6,
                      uppercaseCharCount: 1,
                      numericCharCount: 1,
                      specialCharCount: 1,
                      onSuccess: () {},
                      controller: passwordController),
                SizedBox(
                  height: 20,
                ),
                CustomPasswordFormField(
                  controller: rePasswordController,
                  labelText: 'Confirm Password',
                  focusNode: focusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  backgroundColor: Colors.white.withOpacity(0.6),
                  isDisabled: false,
                  title: 'Register',
                  splashColor: Colors.white,
                  titleColor: Colors.black,
                  width: 200,
                  loading: ref
                      .watch(authNotifierProvider)
                      .maybeWhen(orElse: () => false, loading: () => true),
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      ref.read(authNotifierProvider.notifier).signUp(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                    }
                  },
                ),
                SizedBox(height: 40),
                SmallText(
                  text: "you have an account",
                  color: Color.fromARGB(219, 255, 255, 255),
                  size: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallText(
                      text: "Go to the",
                      color: Color.fromARGB(219, 255, 255, 255),
                      size: 16,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/login'),
                          child: SmallText(
                            text: 'Sign In ',
                            color: Colors.white,
                            size: 16,
                          )),
                    ),
                    SmallText(
                      text: "page",
                      color: Color.fromARGB(219, 255, 255, 255),
                      size: 16,
                    ),
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
