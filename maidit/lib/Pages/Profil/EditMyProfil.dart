// ignore_for_file: file_names

import 'package:flutter/material.dart';

class EditMyProfil extends StatefulWidget {
  const EditMyProfil({super.key});

  @override
  State<EditMyProfil> createState() => _EditMyProfilState();
}

class _EditMyProfilState extends State<EditMyProfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Modifier Mon profil"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Modifications enregistrées')));
                },
                icon: const Icon(Icons.save)),
          ],
        ),
        body: const Center(
          child: Text("Edit my Profil"),
        ));
  }
}
