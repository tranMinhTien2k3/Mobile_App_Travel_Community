import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:travel_app/Components/custom_button.dart';
import 'package:travel_app/Components/text_form_field.dart';
import 'package:travel_app/repositories/auth_provider.dart';

class Forgot_pass extends HookConsumerWidget {
  const Forgot_pass({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final email = useTextEditingController();
        final formKey = useMemoized(() => GlobalKey<FormState>());


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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/image/dark_mountain2.jpg'),
            fit: BoxFit.cover
          )
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.black.withOpacity(0.5)
            ),
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Form(
                child: Column(
                  key: formKey ,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomEmailTextFormField(
                      controller: email, 
                      labelText: 'Email', 
                      icon: Icon(Icons.email_rounded, color: Colors.white,),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                    backgroundColor: Colors.white.withOpacity(0.7),
                    isDisabled: false,
                    title: 'Send email',
                    width: 200,
                    titleColor: Colors.black,
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
                ),
              ),
            ),
          )
        )
      )
    );
  }
}