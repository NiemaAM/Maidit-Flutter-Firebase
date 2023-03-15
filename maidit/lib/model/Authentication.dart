// ignore_for_file: file_names, unused_field

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:shared_preferences/shared_preferences.dart';

import 'UserFirebaseService.dart';

class Authentication {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final UserFirebaseService _userFirebaseService = UserFirebaseService();

//Funcions for user Loggin
  // Function to sign in a user with email and password
  Future<String?> logIn(String email, String password) async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', result.user!.uid);
      return null;
    } on auth.FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Function to check if a user is already signed in
  Future<bool> isUserLogedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('uid');
    return userId != null;
  }

  Future<void> logOut() async {
    auth.FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("uid");
  }
}
