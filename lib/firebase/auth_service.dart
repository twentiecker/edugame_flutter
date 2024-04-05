import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final userEmail = FirebaseAuth.instance.currentUser?.email;

  Future<void> userSignup() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: 'coba2@coba.com',
        password: '1234567890',
      );
      debugPrint(credential.user!.email);
      debugPrint('Sign-up successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> userLogin(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint(credential.user!.email);
      debugPrint('Login successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }
  }

  Future<void> userLogout() async {
    await FirebaseAuth.instance.signOut();
  }

  Stream userState() {
    return FirebaseAuth.instance.authStateChanges();
  }
}
