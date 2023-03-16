// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'SignInInformations.dart';

class SignInChooseProfil extends StatefulWidget {
  const SignInChooseProfil({super.key});

  @override
  State<SignInChooseProfil> createState() => _SignInChooseProfilState();
}

class _SignInChooseProfilState extends State<SignInChooseProfil> {
  bool _isClient = true;
  bool _isMaid = false;
  int profileType = 0;

  int initProfilType() {
    if (_isMaid) {
      return 1;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios, // replace with your desired icon
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          const Expanded(child: SizedBox()),
          Image.asset(
            "assets/logos/logo-blue.png",
            height: 20.0,
            width: 80.0,
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
      body: ListView(children: [
        const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50, bottom: 50),
            child: Text(
              "Choisissez un profil",
              style: TextStyle(
                  color: Color.fromARGB(255, 9, 43, 104),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isClient = true;
                _isMaid = false;
              });
            },
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _isClient
                        ? const Color.fromARGB(255, 0, 105, 242)
                        : const Color.fromARGB(255, 203, 203, 203),
                    width: 2,
                  )),
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Icon(
                    _isClient ? Icons.circle : Icons.circle_outlined,
                    color: _isClient
                        ? const Color.fromARGB(255, 0, 105, 242)
                        : const Color.fromARGB(255, 203, 203, 203),
                  ),
                  const Expanded(child: SizedBox()),
                  const Center(
                      child: Text(
                    "Utilisateur de service",
                    style: TextStyle(fontSize: 16),
                  )),
                  const Expanded(flex: 4, child: SizedBox()),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 60),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isClient = false;
                _isMaid = true;
              });
            },
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _isMaid
                        ? const Color.fromARGB(255, 0, 105, 242)
                        : const Color.fromARGB(255, 203, 203, 203),
                    width: 2,
                  )),
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Icon(
                    _isMaid ? Icons.circle : Icons.circle_outlined,
                    color: _isMaid
                        ? const Color.fromARGB(255, 0, 105, 242)
                        : const Color.fromARGB(255, 203, 203, 203),
                  ),
                  const Expanded(child: SizedBox()),
                  const Center(
                      child: Text(
                    "Fournisseur de service",
                    style: TextStyle(fontSize: 16),
                  )),
                  const Expanded(flex: 4, child: SizedBox()),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Expanded(flex: 6, child: SizedBox()),
              Icon(
                Icons.circle,
                size: 10,
                color: Color.fromARGB(255, 0, 105, 242),
              ),
              Expanded(child: SizedBox()),
              Icon(
                Icons.circle,
                size: 10,
                color: Color.fromARGB(255, 203, 203, 203),
              ),
              Expanded(child: SizedBox()),
              Icon(
                Icons.circle,
                size: 10,
                color: Color.fromARGB(255, 203, 203, 203),
              ),
              Expanded(flex: 6, child: SizedBox()),
            ],
          ),
        ),
        Center(
          child: SizedBox(
            width: 140,
            height: 40,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 239, 31, 118)),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInInformations(
                        profilType: initProfilType(),
                      ),
                    ),
                  );
                },
                child: Row(
                  children: const [
                    Expanded(child: SizedBox()),
                    Text("Suivant"),
                    Expanded(child: SizedBox()),
                    Icon(Icons.arrow_right_alt),
                    Expanded(child: SizedBox()),
                  ],
                )),
          ),
        ),
      ]),
    );
  }
}
