// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../../model/Authentication.dart';
import 'SignInChooseProfil.dart';
import 'package:maidit/Pages/home.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  bool _passwordVisible = false;

  LogAccount(String email, String password) async {
    Authentication auth = Authentication();
    String? errorMessage = await auth.logIn(email, password);
    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 239, 31, 118),
          content: Text('Identifiants incorrectes')));
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 105, 242),
        body: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Image.asset(
                  "assets/logos/logo-white.png",
                  height: 30.0,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 450,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(children: [
                    const Expanded(child: SizedBox()),
                    const Text(
                      "Vous avez déjà un compte ?",
                      style: TextStyle(
                          color: Color.fromARGB(255, 9, 43, 104), fontSize: 15),
                    ),
                    const Text(
                      "Connectez-vous",
                      style: TextStyle(
                          color: Color.fromARGB(255, 9, 43, 104),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 35, left: 20, right: 20),
                      child: TextField(
                        controller: _EmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Adresse e-mail',
                          labelStyle: TextStyle(color: Colors.blue),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: TextField(
                        controller: _PasswordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Mot de passe',
                          labelStyle: const TextStyle(color: Colors.blue),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 239, 31, 118)),
                        onPressed: () {
                          if (!EmailValidator.validate(_EmailController.text)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor:
                                        Color.fromARGB(255, 239, 31, 118),
                                    content: Text('Adresse mail non valide')));
                          } else {
                            LogAccount(_EmailController.text,
                                _PasswordController.text);
                          }
                        },
                        child: SizedBox(
                            width: width - 110,
                            height: 50,
                            child: const Center(child: Text("Se connecter")))),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 237, 243, 255)),
                          onPressed: () {},
                          child: SizedBox(
                              width: width - 110,
                              height: 50,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 10),
                                    child: Image.network(
                                      "https://cdn-icons-png.flaticon.com/512/300/300221.png",
                                      fit: BoxFit.cover,
                                      height: 25.0,
                                    ),
                                  ),
                                  const Center(
                                      child: Text(
                                    "Se connecter avec Google",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 9, 43, 104)),
                                  )),
                                ],
                              ))),
                    ),
                    const Expanded(child: SizedBox()),
                  ]),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInChooseProfil(),
                    ),
                  );
                },
                child: const Text(
                  "Vous-n'avez pas de compte ?",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}
