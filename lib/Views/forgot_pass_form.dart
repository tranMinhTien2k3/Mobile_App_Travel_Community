import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:travel_app/Widgets/custom_button.dart';
import 'package:travel_app/repositories/auth_provider.dart';

class ForgotPassForm extends HookConsumerWidget {
  const ForgotPassForm({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final email = useTextEditingController();

    ref.listen(authNotifierProvider, (previous, next) {
      next.maybeWhen(
        orElse: () => null,
        authenticated: (user) {
          Navigator.pushNamed(context, '/login');
          // Navigate to any screen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email sended!'),
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              CustomButton(
              backgroundColor: Colors.white.withOpacity(0.7),
              isDisabled: false,
              title: 'Sign in',
              loading: ref
                  .watch(authNotifierProvider)
                  .maybeWhen(orElse: () => false, loading: () => true),
              onPressed: () async {
                ref.read(authNotifierProvider.notifier).forgotPass(
                        email: email.text,
                );            
              }
            ),
            ],
          )
        ),
      )
    );
  }
}