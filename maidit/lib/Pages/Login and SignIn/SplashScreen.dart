// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers, depend_on_referenced_packages, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maidit/Pages/Login%20and%20SignIn/FirstStep.dart';
import 'package:maidit/Pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../firebase_options.dart';
import '../../model/Authentication.dart';
import 'LogIn.dart';
import 'package:firebase_core/firebase_core.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //handel the first time page
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');

    var _duration = const Duration(seconds: 3);

    if (firstTime != null && !firstTime) {
      // Not first time
      return Timer(_duration, navigationPageHome);
    } else {
      // First time
      prefs.setBool('first_time', false);
      return Timer(_duration, navigationPageWel);
    }
  }

  void navigationPageHome() {
    isUserLogged();
  }

  void navigationPageWel() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const FirstStep(),
      ),
    );
  }

  intFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  isUserLogged() async {
    await Firebase.initializeApp();
    Authentication auth = Authentication();
    bool logged = await auth.isUserLogedIn();
    if (logged) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LogIn(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    startTime();
    intFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Expanded(flex: 2, child: SizedBox()),
          Center(
            child: Image.asset(
              "assets/logos/logo-blue.png",
              height: 50.0,
            ),
          ),
          const Text(
            "Made it easy",
            style: TextStyle(
                color: Color.fromARGB(255, 3, 23, 136),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const Expanded(flex: 2, child: SizedBox()),
          const CircularProgressIndicator(),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
