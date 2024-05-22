// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:travel_app/repositories/auth_controller.dart';
// import 'package:travel_app/services/firebase_auth_services.dart';


// // final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(FirebaseAuth.instance));

// final authRepositoryProvider = Provider<AuthRepository>((ref){
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final BuildContext context = ref.watch(buildContextProvider);
//   return AuthRepository(_auth, context);
// });

// final buildContextProvider = Provider<BuildContext>((ref) {
//   final context = ref.watch(navigatorKeyProvider).currentContext;
//   if (context == null) {
//     throw Exception("BuildContext is null");
//   }
//   return context;
// });

// final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) => GlobalKey<NavigatorState>());
// final authWithGoogle = Provider<GoogleSignIn>((ref) => GoogleSignIn());

// final authStateProvider = StreamProvider<User?>((ref) => 
//   ref.read(authRepositoryProvider).authStateChange
// );

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_app/repositories/auth_controller.dart';
import 'package:travel_app/repositories/auth_state.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);


final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final firebasaeStorageProvider = Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);

class AuthNotifier extends StateNotifier<AuthenticationState>{
  AuthNotifier(this._controller) : super (const AuthenticationState.initial());

  final AuthController _controller;

  Future<void> login({required String email, required String password}) async{
    state = const AuthenticationState.loading();
    final response = await _controller.login(email: email, password: password);
    state = response.fold(
      (error) => AuthenticationState.unauthenticated(message: error),
      (response) => AuthenticationState.authenticated(user: response!)
    );
  }

  Future<void> signUp({required String email, required String password}) async{
    state = const AuthenticationState.loading();
    final response = await _controller.signUp(email: email, password: password);
    state = response.fold(
      (error) => AuthenticationState.unauthenticated(message: error),
      (response) => AuthenticationState.authenticated(user: response!)
    );
  }

  Future<void> continueWithGoogle() async{
    state = const AuthenticationState.loading();
    final response = await _controller.continueWithGoogle();
    state = response.fold(
      (error) => AuthenticationState.unauthenticated(message: error),
      (response) => AuthenticationState.authenticated(user: response!)
    ); 
  }

  Future<void> forgotPass({required String email}) async{
    state = const AuthenticationState.loading();
    final response = await _controller.forgotPass(email: email);
    state = response.fold(
      (error) => AuthenticationState.unauthenticated(message: error),
      (response) => AuthenticationState.authenticated(user: response)
    );
  }
}

final authControllerProvider = Provider<AuthController>(
  (ref) => AuthController(ref.read(firebaseAuthProvider), ref),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthenticationState>(
  (ref) => AuthNotifier(ref.read(authControllerProvider),)
);