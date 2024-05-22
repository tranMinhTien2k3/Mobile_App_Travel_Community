// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:travel_app/Widgets/notify.dart';
// import 'package:travel_app/repositories/auth_provider.dart';

// class AuthRepository {
//   const AuthRepository(this._auth, this._context);

//   final FirebaseAuth _auth;
//   final BuildContext _context;

//   Stream<User?> get authStateChange => _auth.idTokenChanges();

//   Future<User?> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return result.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.message == 'user-not-found') {
//         throw FirebaseAuthException('User not found');
//       } else if (e.message == 'wrong-password') {
//         throw FirebaseAuthException('Wrong password');
//       } else {
//         throw FirebaseAuthException('An error occurred. Please try again later');
//       }
//     }
//   }

//   Future<User?> signInWithGoogle(context) async {
//     final GoogleSignIn _googleSignIn = GoogleSignIn();

//     try {
//       final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//             await googleSignInAccount.authentication;

//         final AuthCredential credential = GoogleAuthProvider.credential(
//           idToken: googleSignInAuthentication.idToken,
//           accessToken: googleSignInAuthentication.accessToken,
//         );

//         // Sử dụng Provider từ AuthProvider để đăng nhập
//         await context.read(authWithGoogle).signInWithCredential(credential);
        
//         // Điều hướng sau khi đăng nhập thành công
//         Navigator.pushNamed(_context, "/home_page");
//       }
//     } catch (e) {
//       // Xử lý lỗi
//       showToast(message: "Some error occurred $e");
//     }
//   }

//   Future<void> signOut() async {
//     await _auth.signOut();
//   }
// }

// class FirebaseAuthException implements Exception {
//   final String message;
//   FirebaseAuthException(this.message);

//   @override
//   String toString() {
//     return message;
//   }
// }


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/repositories/auth_provider.dart';

class AuthController{
  final FirebaseAuth _firebaseAuth;
  final Ref _ref;

  AuthController(this._firebaseAuth, this._ref);

  Future<Either<String, User>> signUp({required String email, required String password}) async{
    try{
      final response = await _firebaseAuth.createUserWithEmailAndPassword
      (email: email, password: password);
      return right(response.user!);
    }on FirebaseAuthException catch(e){
      return left(e.message ?? 'Failed to Signup');
    }
  }

  Future<Either<String, User>> login({required String email, required String password}) async{
    try{
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
      return right(response.user!);
    }on FirebaseAuthException catch (e){
      return left(e.message ?? 'Failed to login');
    }
  }

  Future<Either<String, User>> continueWithGoogle() async{
    try{
      final googleSignIn  = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if(googleUser != null){
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final response = await _firebaseAuth.signInWithCredential(credential);
        return right(response.user!);
      }else{
        return left('Unknow Error');
      }
    } on FirebaseAuthException catch (e){
      return left(e.message ?? 'Unknow Error');
    }
  }

  Future<Either<String, User>> forgotPass({required String email}) async{
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return right( _firebaseAuth.currentUser!);
    } on FirebaseAuthException catch (e){
      return left(e.message ?? 'Unknown Error');
    }
  }
}

