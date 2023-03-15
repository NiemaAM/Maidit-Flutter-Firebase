// ignore_for_file: file_names, non_constant_identifier_names, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/UserFirebaseService.dart';
import 'SignInChooseTags.dart';

class SignInCreateProfil extends StatefulWidget {
  const SignInCreateProfil({super.key});

  @override
  State<SignInCreateProfil> createState() => _SignInCreateProfilState();
}

class _SignInCreateProfilState extends State<SignInCreateProfil> {
  final TextEditingController _DescriptionController = TextEditingController();
  int size = 0;
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  CreateAccount(String description, File photo, String genre, String ville,
      String adresse) async {
    UserFirebaseService usr = UserFirebaseService();
    usr.updateUser(description, photo, genre, ville, adresse);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInChooseTags(),
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
            padding: EdgeInsets.only(top: 50, bottom: 60),
            child: Text(
              "Créer un profil",
              style: TextStyle(
                  color: Color.fromARGB(255, 9, 43, 104),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Center(
          child: Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage: FileImage(_image!),
                    )
                  : const CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(
                          'https://cdn-icons-png.flaticon.com/512/3177/3177440.png'),
                    ),
              Positioned(
                  bottom: -3,
                  left: 35,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Selectioner une image'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text('Depuis la camera'),
                                  onTap: () {
                                    _getImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.image),
                                  title: const Text('Depuis la gallerie'),
                                  onTap: () {
                                    _getImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: TextField(
            controller: _DescriptionController,
            onChanged: (value) {
              setState(() {
                size = value.length;
              });
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(150),
            ],
            maxLines: null,
            textInputAction: TextInputAction.newline,
            decoration: const InputDecoration(
              labelText: 'Description',
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
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            "$size/150",
            textAlign: TextAlign.right,
            style: const TextStyle(
                color: Color.fromARGB(255, 239, 31, 118), fontSize: 12),
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
                  CreateAccount(
                      _DescriptionController.text, _image!, '', '', '');
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
