// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:maidit/model/MaidModel.dart';

import '../../widgets/ValidationIcon.dart';

class Validate extends StatefulWidget {
  final Maid maid;
  const Validate({super.key, required this.maid});

  @override
  State<Validate> createState() => _ValidateState();
}

class _ValidateState extends State<Validate> {
  bool _isCash = false;
  bool _isCard = true;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 105, 242),
      appBar: AppBar(
        title: Text(
            "Payer ${widget.maid.nom.replaceFirst(widget.maid.nom.characters.first, widget.maid.nom.characters.first.toUpperCase())} ${widget.maid.prenom.replaceFirst(widget.maid.prenom.characters.first, widget.maid.prenom.characters.first.toUpperCase())}"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Text(
                        "Votre payement a été validé par ${widget.maid.nom.replaceFirst(widget.maid.nom.characters.first, widget.maid.nom.characters.first.toUpperCase())} ${widget.maid.prenom.replaceFirst(widget.maid.prenom.characters.first, widget.maid.prenom.characters.first.toUpperCase())}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 9, 43, 104),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40, bottom: 40),
                      child: const ValidationIcon(
                        validated: true,
                      ),
                    )
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
                  Navigator.pop(context);
                },
                child: const Text("Términer"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
