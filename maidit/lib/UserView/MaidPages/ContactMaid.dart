// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maidit/model/UserHistory.dart';

import '../../Controller/UserFirebaseService.dart';
import '../../model/MaidModel.dart';

class ContactMaid extends StatefulWidget {
  final Maid maid;
  const ContactMaid({super.key, required this.maid});

  @override
  State<ContactMaid> createState() => _ContactMaidState();
}

class _ContactMaidState extends State<ContactMaid> {
  final TextEditingController _MessageController = TextEditingController();
  final TextEditingController _ServiceController = TextEditingController();
  int size = 0;
  DateTime? selectedDate;
  UserHistory newhistory = UserHistory();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 60)));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  _saveToHistory() async {
    UserFirebaseService usr = UserFirebaseService();
    usr.updateUserAddHistory(UserHistory(
        maidId: widget.maid.id,
        service: _ServiceController.text,
        serviceState: 0,
        serviceDate: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 105, 242),
      appBar: AppBar(
          title: Text(
              "Contacter ${widget.maid.nom.replaceFirst(widget.maid.nom.characters.first, widget.maid.nom.characters.first.toUpperCase())} ${widget.maid.prenom.replaceFirst(widget.maid.prenom.characters.first, widget.maid.prenom.characters.first.toUpperCase())}"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios, // replace with your desired icon
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
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
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 30, bottom: 30),
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _ServiceController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-zA-Zéèà ]")),
                        LengthLimitingTextInputFormatter(25),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Service',
                        labelStyle: TextStyle(color: Colors.blue),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          labelText:
                              selectedDate == null ? '' : 'Date du service',
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text(
                                selectedDate != null
                                    ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                    : 'Date du service',
                                style: selectedDate != null
                                    ? null
                                    : const TextStyle(
                                        fontSize: 16, color: Colors.black54)),
                            const Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _MessageController,
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
                        labelText: 'Message',
                        labelStyle: TextStyle(color: Colors.blue),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Center(
            child: SizedBox(
              width: 140,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 239, 31, 118)),
                onPressed: () {
                  if (_ServiceController.text.isEmpty ||
                      _MessageController.text.isEmpty ||
                      selectedDate.toString().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color.fromARGB(255, 239, 31, 118),
                        content:
                            Text('Veuillez remplir les champs manquants')));
                  } else {
                    _saveToHistory();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color.fromARGB(255, 239, 31, 118),
                        content: Text('Demande envoyée')));
                    Navigator.pop(context);
                  }
                },
                child: const Text("Envoyer"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
