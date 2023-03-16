// ignore_for_file: file_names, non_constant_identifier_names, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:maidit/Pages/Login%20and%20SignIn/LogIn.dart';
import 'package:maidit/Pages/home.dart';

import '../../model/Authentication.dart';
import '../../model/MaidFirebaseService.dart';
import '../../model/UserFirebaseService.dart';
import '../../model/UserModel.dart';

class SignInChooseTags extends StatefulWidget {
  final int profilType;
  const SignInChooseTags({super.key, required this.profilType});

  @override
  State<SignInChooseTags> createState() => _SignInChooseTagsState();
}

class _SignInChooseTagsState extends State<SignInChooseTags> {
  final List<String> _cast = <String>[
    'Cuisine',
    'Ménage',
    'Nettoyage',
    'Garde d\'enfants',
    'Rangement',
    'Patisserie',
    'Lessive',
    'Vaisselle',
  ];
  List<String> _chosenTags = <String>[];
  Iterable<Widget> get tagsWidgets {
    return _chosenTags.map((String tag) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Chip(
          label: Text(
            tag,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          backgroundColor: const Color.fromARGB(255, 239, 31, 118),
          deleteIconColor: Colors.white,
          onDeleted: () {
            setState(() {
              _chosenTags.removeWhere((String entry) {
                return entry == tag;
              });
            });
          },
        ),
      );
    });
  }

  Iterable<Widget> get addtagsWidgets {
    return _cast.map((String tag) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 105, 242),
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            constraints: const BoxConstraints(
              maxHeight: 40,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 13, right: 13, top: 5, bottom: 6),
              child: Text(
                tag,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          onTap: () {
            setState(() {
              _chosenTags.add(tag);
              var result = _chosenTags.toSet().toList();
              _chosenTags = result;
            });
          },
        ),
      );
    });
  }

  User? currentUser = User(
    id: '',
    nom: '',
    prenom: '',
    genre: '',
    email: '',
    phone: 0,
    ville: '',
    adresse: '',
    registerDate: DateTime(0, 0, 0),
    description: '',
    photo: "https://cdn-icons-png.flaticon.com/512/3177/3177440.png",
    tags: [],
    events: {},
    savedMaids: [],
  );

  AddTags() async {
    if (widget.profilType == 0) {
      UserFirebaseService usr = UserFirebaseService();
      usr.updateUserAddTags(_chosenTags);
      currentUser = await usr.getUser();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 239, 31, 118),
          content: Text('Votre compte a été créé avec succès !')));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            user: currentUser!,
            maids: const [],
            savedmaids: const [],
          ),
        ),
      );
    } else {
      MaidFirebaseService md = MaidFirebaseService();
      md.updateMaidAddTags(_chosenTags);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color.fromARGB(255, 239, 31, 118),
          content: Text('Maid créé avec succès !')));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LogIn(),
        ),
      );
      Authentication auth = Authentication();
      auth.logOut();
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
            padding: EdgeInsets.only(top: 50, bottom: 60),
            child: Text(
              "Quels sont vos centres d'intérêt ?",
              style: TextStyle(
                  color: Color.fromARGB(255, 9, 43, 104),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Center(
          child: Wrap(
            children: addtagsWidgets.toList(),
          ),
        ),
        const Center(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              height: 20,
              thickness: 2,
              indent: 8,
              endIndent: 8,
              color: Color.fromARGB(255, 203, 203, 203),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: tagsWidgets.toList(),
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
                color: Color.fromARGB(255, 203, 203, 203),
              ),
              Expanded(child: SizedBox()),
              Icon(
                Icons.circle,
                size: 10,
                color: Color.fromARGB(255, 0, 105, 242),
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
                AddTags();
              },
              child: const Center(child: Text("Términer")),
            ),
          ),
        ),
      ]),
    );
  }
}
