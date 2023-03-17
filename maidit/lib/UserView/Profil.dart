// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import '../Controller/UserFirebaseService.dart';
import '../model/UserModel.dart';
import 'Profil/ViewMyProfil.dart';
import 'Profil/EditMyProfil.dart';

class Profil extends StatefulWidget {
  final User user;
  const Profil({
    super.key,
    required this.user,
  });

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
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

  Future<void> _getProfil() async {
    UserFirebaseService usr = UserFirebaseService();
    User? _currentUser = await usr.getUser();
    setState(() {
      currentUser = _currentUser;
    });
  }

  Future<void> _navigateToSecondPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMyProfil(
          user: currentUser!,
        ),
      ),
    );
    if (result != null) {
      _getProfil();
    }
  }

  @override
  void initState() {
    super.initState();
    _getProfil();
  }

  @override
  Widget build(BuildContext context) {
    _getProfil();
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Mon profil"),
          actions: [
            IconButton(
                onPressed: () {
                  _navigateToSecondPage();
                },
                icon: const Icon(Icons.edit)),
          ],
        ),
        body: currentUser!.id == ''
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: ViewMyProfil(
                user: currentUser!,
              )));
  }
}
