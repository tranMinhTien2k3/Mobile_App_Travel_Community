import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/repositories/auth_provider.dart';
import 'package:travel_app/repositories/chagne_pass_provider.dart';

class ChangePassForm extends ConsumerStatefulWidget {
  const ChangePassForm({super.key});

  @override
  ConsumerState<ChangePassForm> createState() => _ChangePassFormState();
}

class _ChangePassFormState extends ConsumerState<ChangePassForm> {

  @override
  Widget build(BuildContext context) {
    final TextEditingController _oldPasswordController = TextEditingController();
    final TextEditingController _newPasswordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    bool _isOldPasswordValid = true;

    void changePass() async{
      final currentPass = ref.watch(currentPasswordProvider.notifier).state;
      if(_formKey.currentState!.validate()){
        bool isOldPassCorrect = await isOldPass(currentPass!);
        if(!isOldPassCorrect){
          setState(() {
            _isOldPasswordValid = false;
          });
          return;
        }

        String newPass = _newPasswordController.text.trim();
        ref.read(authControllerProvider).changePass(password: newPass);

        _oldPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();

        Navigator.pop(context);
      }
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
                errorText: _isOldPasswordValid ? 'null' : 'Current Password is not correct'
              ),
              validator: (value){
                ref.read(currentPasswordProvider.notifier).state = value ?? '';
                if(value == null || value.isEmpty){
                  return 'Please enter your Password';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
              validator: (value){
                ref.read(newPasswordProvider.notifier).state = value ?? null;
                if(value == null || value.isEmpty){
                  return 'Please enter your new Password';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password'
              ),
              validator: (value){
                ref.read(confirmPasswordProvider.notifier).state = value ?? '';
                if(value == null || value.isEmpty){
                  return 'Please confirm your password';
                }
                if(value != _newPasswordController.text){
                  return 'Your Password do not match';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async{
                changePass();
              },
              child: Text('Change Password'),
            )
          ],
        ),
      ),
    );
  }
}

bool isStrongPass(String Password){
  if(Password.length < 6){
    return false;
  }
  RegExp specialChars = RegExp(r'[!@#%^&*(),.?":{}|<>]');
  if(!specialChars.hasMatch(Password)){
    return false;
  }
  RegExp upperCase = RegExp(r'[A-Z]');
  RegExp lowerCase = RegExp(r'[a-z]');
  if(!upperCase.hasMatch(Password) && !lowerCase.hasMatch(Password)){
    return false;
  }
  RegExp digits = RegExp(r'\d');
  if(!digits.hasMatch(Password)){
    return false;
  }

  return true;
}

Future<bool> isOldPass(String currentPass) async{
  try{
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null){
      throw Exception('Have error, please try again');
    }

    AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: currentPass);
    await user.reauthenticateWithCredential(credential);
    return true;
  } catch(error){
    print('Error: $error');
    return false;
  }
}