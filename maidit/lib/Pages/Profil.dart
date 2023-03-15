// ignore_for_file: file_names

import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mon profil"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditMyProfil(),
                    ),
                  );
                },
                icon: const Icon(Icons.edit)),
          ],
        ),
        body: SingleChildScrollView(
            child: ViewMyProfil(
          user: widget.user,
        )));
  }
}
