import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_app/Widgets/form_container.dart';
import 'package:travel_app/Widgets/notify.dart';
import 'package:travel_app/services/firebase_auth_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<Sign_up> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _fistnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _comfirmpasswordController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _fistnameController.dispose();
    _lastnameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _comfirmpasswordController.dispose();
    super.dispose();
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _comfirmpasswordController.text.trim()) {
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.green[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Đăng ký tài khoản",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _fistnameController,
                hintText: "Fist Name",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _lastnameController,
                hintText: "Last Name",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _ageController,
                hintText: "Age",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _comfirmpasswordController,
                hintText: "Comfirm Password",
                isPasswordField: true,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  _signUp();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: isSigningUp
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future addUserDetails(String fistName, String lastName, String email, int age,
      String Id) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');
    await usersCollection.doc(Id).set({
      'fist name': fistName,
      'last name': lastName,
      'email': email,
      'age': age,
      'address': "",
      'phone': "",
      'image':
          "https://firebasestorage.googleapis.com/v0/b/appdemo-88d5f.appspot.com/o/avt%2Favt.jpg?alt=media&token=4bcb97c6-fa56-418d-8cc8-a8d2621215a6",
      'notifications': ""
    });
  }

  void _signUp() async {
    if (passwordConfirmed()) {
      setState(() {
        isSigningUp = true;
      });

      String email = _emailController.text;
      String password = _passwordController.text;
      String fistName = _fistnameController.text;
      String lastName = _lastnameController.text;
      int age = int.parse(_ageController.text);

      User? user = await _auth.signUpWithEmailAndPassword(email, password);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String userId = userCredential.user!.uid;
      addUserDetails(fistName, lastName, email, age, userId);
      setState(() {
        isSigningUp = false;
      });
      if (user != null) {
        showToast(message: "User is successfully created");
        Navigator.pushNamed(context, "/home");
      } else {
        showToast(message: "Some error happend");
      }
    } else {
      showToast(message: "password re-enter does not match");
    }
  }
}
