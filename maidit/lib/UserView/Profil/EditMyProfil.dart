// ignore_for_file: file_names, non_constant_identifier_names, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controller/UserFirebaseService.dart';
import '../../model/UserModel.dart';

class EditMyProfil extends StatefulWidget {
  final User user;
  const EditMyProfil({super.key, required this.user});

  @override
  State<EditMyProfil> createState() => _EditMyProfilState();
}

class _EditMyProfilState extends State<EditMyProfil> {
  final TextEditingController _NomController = TextEditingController();
  final TextEditingController _PrenomController = TextEditingController();
  final TextEditingController _DescriptionController = TextEditingController();
  List<String> tags = [];
  List<String> _chosenTags = [];
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? noImage;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        noImage = null;
      } else {}
    });
  }

  editUser() async {
    UserFirebaseService usr = UserFirebaseService();
    usr.updateUserEdit(_NomController.text, _PrenomController.text,
        _DescriptionController.text, _image, noImage, _chosenTags);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _NomController.text = widget.user.nom;
      _PrenomController.text = widget.user.prenom;
      _DescriptionController.text = widget.user.description;
      tags = widget.user.tags!;
      _chosenTags = widget.user.tags!;
      noImage = widget.user.photo;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Modifier Mon profil"),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios, // replace with your desired icon
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  editUser();
                  Navigator.pop(context, true);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Modifications enregistrées')));
                },
                icon: const Icon(Icons.save)),
          ],
        ),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  color: Colors.grey[50],
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          noImage == null
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: CircleAvatar(
                                    radius: 70,
                                    backgroundImage: FileImage(_image!),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: CircleAvatar(
                                    radius: 70,
                                    backgroundImage: NetworkImage(noImage!),
                                  ),
                                ),
                          Positioned(
                              bottom: 0,
                              left: 60,
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            const Text('Selectioner une image'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading:
                                                  const Icon(Icons.camera_alt),
                                              title: const Text(
                                                  'Depuis la camera'),
                                              onTap: () {
                                                _getImage(ImageSource.camera);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(Icons.image),
                                              title: const Text(
                                                  'Depuis la gallerie'),
                                              onTap: () {
                                                _getImage(ImageSource.gallery);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading: const Icon(
                                                  Icons.image_not_supported),
                                              title: const Text(
                                                  'Supprimer la photo de profil'),
                                              onTap: () {
                                                setState(() {
                                                  noImage =
                                                      'https://cdn-icons-png.flaticon.com/512/3177/3177440.png';
                                                });
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(child: SizedBox()),
                          SizedBox(
                            width: 150,
                            child: TextField(
                              controller: _NomController,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: TextField(
                              controller: _PrenomController,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: TextField(
                              controller: _DescriptionController,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black45),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Mes centres d'intérêts",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Center(
                    child: Wrap(
                      children: addtagsWidgets.toList(),
                    ),
                  ),
                ),
                Container(
                  width: width,
                  color: Colors.grey[50],
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Wrap(
                      children: tagsWidgets.toList(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
