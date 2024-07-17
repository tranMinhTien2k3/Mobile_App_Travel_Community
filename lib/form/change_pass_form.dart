// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:travel_app/repositories/auth_provider.dart';
// import 'package:travel_app/repositories/chagne_pass_provider.dart';
// import 'package:travel_app/repositories/theme_notifier.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';

// class ChangePassForm extends ConsumerStatefulWidget {
//   const ChangePassForm({super.key});

//   @override
//   ConsumerState<ChangePassForm> createState() => _ChangePassFormState();
// }

// class _ChangePassFormState extends ConsumerState<ChangePassForm>  {

  
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _oldPasswordController = TextEditingController();
//     final TextEditingController _newPasswordController = TextEditingController();
//     final TextEditingController _confirmPasswordController = TextEditingController();
//     final _formKey = useMemoized(() => GlobalKey<FormState>());
//     final isDarkMode = ref.watch(themeNotifierProvider) == ThemeModeState.dark;
//     bool _isOldPasswordValid = true;

//     void changePass() async{
//       final currentPass = ref.watch(currentPasswordProvider.notifier).state;
//       if(_formKey.currentState!.validate()){
//         bool isOldPassCorrect = await isOldPass(currentPass!);
//         if(!isOldPassCorrect){
//           setState(() {
//             _isOldPasswordValid = false;
//           });
//           return;
//         }

//         String newPass = _newPasswordController.text.trim();
//         ref.read(authControllerProvider).changePass(password: newPass);

//         _oldPasswordController.clear();
//         _newPasswordController.clear();
//         _confirmPasswordController.clear();

//         Navigator.pop(context);
//       }
//     }

//     return Padding(
//       padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             TextFormField(
//               controller: _oldPasswordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Current Password',
//                 errorText: _isOldPasswordValid ? 'null' : 'Current Password is not correct',
//                 border: OutlineInputBorder(
//                   borderSide: const BorderSide(
//                     width: 1
//                   ),
//                 borderRadius: BorderRadius.circular(20.0)
//                 )
//               ),
//               validator: (value){
//                 ref.read(currentPasswordProvider.notifier).state = value ?? '';
//                 if(value == null || value.isEmpty){
//                   return 'Please enter your Password';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _newPasswordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'New Password',
//                 border: OutlineInputBorder(
//                   borderSide: const BorderSide(
//                     width: 1
//                   ),
//                 borderRadius: BorderRadius.circular(20.0)
//                 )
//               ),
//               validator: (value){
//                 ref.read(newPasswordProvider.notifier).state = value ?? null;
//                 if(value == null || value.isEmpty){
//                   return 'Please enter your new Password';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 20,),
//             TextFormField(
//               controller: _confirmPasswordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Confirm Password',
//                 border: OutlineInputBorder(
//                   borderSide: const BorderSide(
//                     width: 1
//                   ),
//                 borderRadius: BorderRadius.circular(20.0)
//                 )
//               ),
//               validator: (value){
//                 ref.read(confirmPasswordProvider.notifier).state = value ?? '';
//                 if(value == null || value.isEmpty){
//                   return 'Please confirm your password';
//                 }
//                 if(value != _newPasswordController.text){
//                   return 'Your Password do not match';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 20,),
//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 onPressed: () async{
//                   changePass();
//                 },
//                 child: Text('Change Password'),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// bool isStrongPass(String Password){
//   if(Password.length < 6){
//     return false;
//   }
//   RegExp specialChars = RegExp(r'[!@#%^&*(),.?":{}|<>]');
//   if(!specialChars.hasMatch(Password)){
//     return false;
//   }
//   RegExp upperCase = RegExp(r'[A-Z]');
//   RegExp lowerCase = RegExp(r'[a-z]');
//   if(!upperCase.hasMatch(Password) && !lowerCase.hasMatch(Password)){
//     return false;
//   }
//   RegExp digits = RegExp(r'\d');
//   if(!digits.hasMatch(Password)){
//     return false;
//   }

//   return true;
// }

// Future<bool> isOldPass(String currentPass) async{
//   try{
//     User? user = FirebaseAuth.instance.currentUser;
//     if(user == null){
//       throw Exception('Have error, please try again');
//     }

//     AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: currentPass);
//     await user.reauthenticateWithCredential(credential);
//     return true;
//   } catch(error){
//     print('Error: $error');
//     return false;
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/Widgets/notify.dart';
import 'package:travel_app/form/login_form.dart';
import 'package:travel_app/repositories/auth_provider.dart';
import 'package:travel_app/repositories/chagne_pass_provider.dart';
import 'package:travel_app/repositories/theme_notifier.dart';


final oldPassObscureTextProvider = StateProvider<bool>((ref) => true);
final newPassObscureTextProvider = StateProvider<bool>((ref) => true);
final confirmPassObscureTextProvider = StateProvider<bool>((ref) => true);
class ChangePassForm extends HookConsumerWidget {
  const ChangePassForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _oldPasswordController = useTextEditingController();
    final TextEditingController _newPasswordController = useTextEditingController();
    final TextEditingController _confirmPasswordController = useTextEditingController();
    final _formKey = useMemoized(() => GlobalKey<FormState>());
    final FocusNode oldPassFocus = FocusNode();
    final FocusNode newPassFocus = FocusNode();
    final FocusNode confirmPassFocus = FocusNode();
    final isDarkMode = ref.watch(themeNotifierProvider) == ThemeModeState.dark;
    final bool newObscureText = ref.watch(newPassObscureTextProvider);
    final bool oldObsercureText = ref.watch(oldPassObscureTextProvider);
    final bool confirmObsercureText = ref.watch(confirmPassObscureTextProvider);
    

    void changePass() async {
      final currentPass = ref.read(currentPasswordProvider.notifier).state;
      if (_formKey.currentState!.validate()) {
        bool isOldPassCorrect = await isOldPass(_oldPasswordController.text);
        if (!isOldPassCorrect) {
          ref.read(isOldPasswordCorrectProvider.notifier).state = true;
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
      padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _oldPasswordController,
              focusNode: oldPassFocus,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(ref.watch(oldPassObscureTextProvider.notifier).state? Icons.visibility : Icons.visibility_off),
                  onPressed: (){
                    ref.read(oldPassObscureTextProvider.notifier).update((state) => !state);
                    // print(ref.watch(obscureTextProvider.notifier).state);
                  },
                ),
                labelText: 'Current Password',
                // errorText: ref.watch(isOldPasswordCorrectProvider) ? null : 'Current Password is not correct',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              obscureText: oldObsercureText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Password';
                }
                return null;
              },
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: _newPasswordController,
              focusNode: newPassFocus,
              obscureText: newObscureText,
              decoration: InputDecoration(
                labelText: 'New Password',
                suffixIcon: IconButton(
                  icon: Icon(ref.watch(newPassObscureTextProvider.notifier).state? Icons.visibility : Icons.visibility_off),
                  onPressed: (){
                    ref.read(newPassObscureTextProvider.notifier).update((state) => !state);
                    // print(ref.watch(obscureTextProvider.notifier).state);
                  },
                ),                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              validator: (value) {
                // ref.read(newPasswordProvider.notifier).state = value ?? null;
                if (value == null || value.isEmpty) {
                  return 'Please enter your new Password';
                }else if(!isStrongPass(value)){
                  return 'Your password is not strong enough';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _confirmPasswordController,
              focusNode: confirmPassFocus,
              obscureText: confirmObsercureText,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                suffixIcon: IconButton(
                  icon: Icon(ref.watch(confirmPassObscureTextProvider.notifier).state? Icons.visibility : Icons.visibility_off),
                  onPressed: (){
                    ref.read(confirmPassObscureTextProvider.notifier).update((state) => !state);
                    // print(ref.watch(obscureTextProvider.notifier).state);
                  },
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              validator: (value) {
                // ref.read(confirmPasswordProvider.notifier).state = value ?? '';
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }else if(!isStrongPass(value)){
                  return 'Your password is not strong enough';
                }
                if (value != _newPasswordController.text) {
                  return 'Your Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  final oldPass = isOldPass(_oldPasswordController.text);
                  if(await oldPass){
                    if(_formKey.currentState?.validate() ?? false){
                      changePass();
                      showToast(message: 'Change Password successful');
                    }
                    showToast(message: 'Change password failed');
                  }else{
                    showToast(message: 'Your old password is not correct');
                  }
                },
                child: Text('Change Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool isStrongPass(String password) {
  if (password.length < 6) {
    return false;
  }
  RegExp specialChars = RegExp(r'[!@#%^&*(),.?":{}|<>]');
  if (!specialChars.hasMatch(password)) {
    return false;
  }
  RegExp upperCase = RegExp(r'[A-Z]');
  RegExp lowerCase = RegExp(r'[a-z]');
  if (!upperCase.hasMatch(password) || !lowerCase.hasMatch(password)) {
    return false;
  }
  RegExp digits = RegExp(r'\d');
  if (!digits.hasMatch(password)) {
    return false;
  }
  return true;
}

Future<bool> isOldPass(String currentPass) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated.');
    }
    AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: currentPass);
    await user.reauthenticateWithCredential(credential);
    return true;
  } catch (error) {
    print('Error: $error');
    return false;
  }
}
