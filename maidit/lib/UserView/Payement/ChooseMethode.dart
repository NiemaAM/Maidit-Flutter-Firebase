// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:maidit/UserView/Payement/Validate.dart';
import 'package:maidit/model/MaidModel.dart';

class ChooseMethode extends StatefulWidget {
  final Maid maid;
  const ChooseMethode({super.key, required this.maid});

  @override
  State<ChooseMethode> createState() => _ChooseMethodeState();
}

class _ChooseMethodeState extends State<ChooseMethode> {
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
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: Text(
                        "Choisissez un moyen de payement",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromARGB(255, 9, 43, 104),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isCard = true;
                            _isCash = false;
                          });
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _isCard
                                    ? const Color.fromARGB(255, 0, 105, 242)
                                    : const Color.fromARGB(255, 203, 203, 203),
                                width: 2,
                              )),
                          child: Row(
                            children: [
                              const Expanded(child: SizedBox()),
                              Icon(
                                _isCard ? Icons.circle : Icons.circle_outlined,
                                color: _isCard
                                    ? const Color.fromARGB(255, 0, 105, 242)
                                    : const Color.fromARGB(255, 203, 203, 203),
                              ),
                              const Expanded(child: SizedBox()),
                              const Center(
                                  child: Text(
                                "Payer par Carte",
                                style: TextStyle(fontSize: 16),
                              )),
                              const Expanded(flex: 4, child: SizedBox()),
                              Icon(
                                Icons.payment,
                                color: _isCard
                                    ? const Color.fromARGB(255, 0, 105, 242)
                                    : const Color.fromARGB(255, 203, 203, 203),
                              ),
                              const Expanded(flex: 1, child: SizedBox()),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, right: 10, left: 10, bottom: 20),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isCard = false;
                            _isCash = true;
                          });
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: _isCash
                                    ? const Color.fromARGB(255, 0, 105, 242)
                                    : const Color.fromARGB(255, 203, 203, 203),
                                width: 2,
                              )),
                          child: Row(
                            children: [
                              const Expanded(child: SizedBox()),
                              Icon(
                                _isCash ? Icons.circle : Icons.circle_outlined,
                                color: _isCash
                                    ? const Color.fromARGB(255, 0, 105, 242)
                                    : const Color.fromARGB(255, 203, 203, 203),
                              ),
                              const Expanded(child: SizedBox()),
                              const Center(
                                  child: Text(
                                "Payer Cash",
                                style: TextStyle(fontSize: 16),
                              )),
                              const Expanded(flex: 4, child: SizedBox()),
                              Icon(
                                Icons.payments,
                                color: _isCash
                                    ? const Color.fromARGB(255, 0, 105, 242)
                                    : const Color.fromARGB(255, 203, 203, 203),
                              ),
                              const Expanded(flex: 1, child: SizedBox()),
                            ],
                          ),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Validate(maid: widget.maid),
                    ),
                  );
                },
                child: const Text("Valider"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
