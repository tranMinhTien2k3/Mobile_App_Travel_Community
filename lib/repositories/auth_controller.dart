
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_app/repositories/auth_provider.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth;
  final Ref _ref;

  AuthController(this._firebaseAuth, this._ref);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Xu ly dang nhap dang ky voi email va mat khau
  Future<Either<String, User>> signUp(
      {required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(response.user!);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to Signup');
    }
  }


  //  Xu ly dang nhap voi email va mat khau
  Future<Either<String, User>> login(
      {required String email, required String password}) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(response.user!);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Failed to login');
    }
  }


  // Xu ly dang nhap voi tai khoan Google
  Future<Either<String, User>> continueWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final response = await _firebaseAuth.signInWithCredential(credential);
        return right(response.user!);
      } else {
        return left('Unknow Error');
      }
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Unknow Error');
    }
  }




  // Xu ly dang nhap voi tai khoan Facebook
  Future<Either<String, User>> continueWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      );
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);
        final UserCredential response =
            await _firebaseAuth.signInWithCredential(credential);
        return right(response.user!);
      } else if (result.status == LoginStatus.cancelled) {
        return left('Login cancelled');
      } else if (result.status == LoginStatus.failed) {
        return left('Login failed: ${result.message}');
      } else {
        return left('Unknown error 1');
      }
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Unknown error 2');
    } catch (e) {
      return left('Unknown error 3');
    }
  }


  // Xu ly quen mat khau
  Future<Either<String, User>> forgotPass({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return right(_firebaseAuth.currentUser!);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Unknown Error');
    }
  }

  User?  gerCurrenrUser(){
    return _firebaseAuth.currentUser;
  }
}
