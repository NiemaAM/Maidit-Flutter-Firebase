// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'LogIn.dart';

class FirstStep extends StatefulWidget {
  const FirstStep({super.key});

  @override
  State<FirstStep> createState() => _FirstStepState();
}

class _FirstStepState extends State<FirstStep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 105, 242),
      body: Column(
        children: [
          const Expanded(child: SizedBox()),
          Center(
            child: Image.asset(
              "assets/logos/logo-white.png",
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
          const Expanded(child: SizedBox()),
          Center(
            child: Image.network(
              "https://cdn-icons-png.flaticon.com/512/1886/1886856.png",
              fit: BoxFit.cover,
              height: 150.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              "Bienvenue sur Maidit, l'application\nd'aide à domicile facile et rapide!",
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const Expanded(child: SizedBox()),
          SizedBox(
            width: 140,
            height: 40,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 239, 31, 118)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogIn(),
                    ),
                  );
                },
                child: Row(
                  children: const [
                    Expanded(child: SizedBox()),
                    Text("Commencer"),
                    Expanded(flex: 100, child: SizedBox()),
                    Icon(Icons.arrow_right_alt),
                    Expanded(child: SizedBox()),
                  ],
                )),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
