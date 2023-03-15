// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maidit/Pages/Login%20and%20SignIn/FirstStep.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LogIn.dart';

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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LogIn(),
      ),
    );
  }

  void navigationPageWel() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const FirstStep(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
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
