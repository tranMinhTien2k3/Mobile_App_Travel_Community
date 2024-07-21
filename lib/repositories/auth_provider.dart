

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/repositories/auth_controller.dart';
import 'package:travel_app/models/auth_state.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final firebasaeStorageProvider =
    Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);

class AuthNotifier extends StateNotifier<AuthenticationState> {
  AuthNotifier(this._controller) : super(const AuthenticationState.initial());

  final AuthController _controller;

  Future<void> login({required String email, required String password}) async {
    state = const AuthenticationState.loading();
    final response = await _controller.login(email: email, password: password);
    state = response.fold(
        (error) => AuthenticationState.unauthenticated(message: error),
        (response) => AuthenticationState.authenticated(user: response!));
  }

  Future<void> signUp({required String email, required String password}) async {
    state = const AuthenticationState.loading();
    final response = await _controller.signUp(email: email, password: password);
    state = response.fold(
        (error) => AuthenticationState.unauthenticated(message: error),
        (response) => AuthenticationState.authenticated(user: response!));
  }

  Future<void> continueWithGoogle() async {
    state = const AuthenticationState.loading();
    final response = await _controller.continueWithGoogle();
    state = response.fold(
        (error) => AuthenticationState.unauthenticated(message: error),
        (response) => AuthenticationState.authenticated(user: response!));
  }

  Future<void> continueWithFacebook() async {
    state = const AuthenticationState.loading();
    final response = await _controller.continueWithFacebook();
    state = response.fold(
        (error) => AuthenticationState.unauthenticated(message: error),
        (user) => AuthenticationState.authenticated(user: user!));
  }

  Future<void> forgotPass({required String email}) async {
    state = const AuthenticationState.loading();
    final response = await _controller.forgotPass(email: email);
    state = response.fold(
        (error) => AuthenticationState.unauthenticated(message: error),
        (response) => AuthenticationState.passwordResetSuccess());
  }

  Future<void> signOut() async{
    state = const AuthenticationState.loading();
    final response = await _controller.signOut();
    state = response.fold(
      (error) => AuthenticationState.unauthenticated(message: error),
      (response) => AuthenticationState.authenticated(user: response!),
    );
  }

  Future<void> changePass() async{
    state = const AuthenticationState.loading();
    final response = await _controller.changePass(password: '');
    state = response.fold(
      (error) => AuthenticationState.unauthenticated(message: error),
      (response) => AuthenticationState.authenticated(user: response)
    );
  }
}


final authControllerProvider = Provider<AuthController>(
  (ref) => AuthController(ref.read(firebaseAuthProvider), ref),
);

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthenticationState>(
        (ref) => AuthNotifier(
              ref.read(authControllerProvider),
            ));


final userProvider = StreamProvider<User?>( (ref) {
  final authService = ref.watch(authControllerProvider);
  return authService.authStateChanges;
});

