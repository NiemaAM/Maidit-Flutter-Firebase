// ignore_for_file: file_names

import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
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
