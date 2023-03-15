// ignore_for_file: file_names, non_constant_identifier_names

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maidit/model/UserFirebaseService.dart';
import 'package:maidit/model/UserModel.dart';
import 'SignInCreateProfil.dart';

class SignInInformations extends StatefulWidget {
  const SignInInformations({super.key});

  @override
  State<SignInInformations> createState() => _SignInInformationsState();
}

class _SignInInformationsState extends State<SignInInformations> {
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();
  final TextEditingController _NomController = TextEditingController();
  final TextEditingController _PrenomController = TextEditingController();
  final TextEditingController _PhoneController = TextEditingController();
  bool _passwordVisible = false;

  CreateAccount(String nom, String prenom, String email, String password,
      int phone) async {
    User createduser = User(
      id: '',
      nom: nom,
      prenom: prenom,
      genre: '',
      email: email,
      phone: phone,
      ville: '',
      adresse: '',
      registerDate: DateTime.now(),
      description: '',
      photo: "https://cdn-icons-png.flaticon.com/512/3177/3177440.png",
      tags: [],
      events: {},
      savedMaids: [],
      messages: {},
      history: {},
    );
    UserFirebaseService usr = UserFirebaseService();
    usr.createUser(createduser, email, password);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInCreateProfil(),
      ),
    );
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
            padding: EdgeInsets.only(top: 50, bottom: 20),
            child: Text(
              "Informations Personnelles",
              style: TextStyle(
                  color: Color.fromARGB(255, 9, 43, 104),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 35, left: 20, right: 20),
          child: TextField(
            controller: _EmailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Adresse e-mail*',
              labelStyle: TextStyle(color: Colors.blue),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: TextField(
            controller: _PasswordController,
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              labelText: 'Mot de passe*',
              labelStyle: const TextStyle(color: Colors.blue),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
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
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: TextField(
            controller: _NomController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
              LengthLimitingTextInputFormatter(25),
            ],
            decoration: const InputDecoration(
              labelText: 'Nom*',
              labelStyle: TextStyle(color: Colors.blue),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: TextField(
            controller: _PrenomController,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
              LengthLimitingTextInputFormatter(25),
            ],
            decoration: const InputDecoration(
              labelText: 'Prénom*',
              labelStyle: TextStyle(color: Colors.blue),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: TextField(
            controller: _PhoneController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(9),
            ],
            decoration: const InputDecoration(
              labelText: 'Téléphone*',
              prefix: Text("+212  "),
              labelStyle: TextStyle(color: Colors.blue),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 40, top: 40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Expanded(flex: 6, child: SizedBox()),
              Icon(
                Icons.circle,
                size: 10,
                color: Color.fromARGB(255, 203, 203, 203),
              ),
              Expanded(child: SizedBox()),
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
                  if (_EmailController.text.isEmpty ||
                      _PasswordController.text.isEmpty ||
                      _NomController.text.isEmpty ||
                      _PrenomController.text.isEmpty ||
                      _PhoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color.fromARGB(255, 0, 105, 242),
                        content:
                            Text('Veuillez renseigner les champs manquants')));
                  } else if (_PasswordController.text.length < 5) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color.fromARGB(255, 0, 105, 242),
                        content: Text('Mot de passe non valide')));
                  } else if (!EmailValidator.validate(_EmailController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color.fromARGB(255, 0, 105, 242),
                        content: Text('Adresse mail non valide')));
                  } else if (_PhoneController.text.length < 9) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color.fromARGB(255, 0, 105, 242),
                        content: Text('Numéro de téléphone non valide')));
                  } else {
                    CreateAccount(
                        _NomController.text,
                        _PrenomController.text,
                        _EmailController.text,
                        _PasswordController.text,
                        int.parse(_PhoneController.text));
                  }
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
