// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SuggestionBloc extends StatefulWidget {
  const SuggestionBloc({super.key});

  @override
  State<SuggestionBloc> createState() => _SuggestionBlocState();
}

class _SuggestionBlocState extends State<SuggestionBloc> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        width: 200,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  // handle icon press
                },
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {
                  // handle icon press
                },
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 25),
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://img.freepik.com/free-photo/pretty-smiling-joyfully-female-with-fair-hair-dressed-casually-looking-with-satisfaction_176420-15187.jpg?w=1060&t=st=1678653484~exp=1678654084~hmac=cc0aaa0057aa2056f47cc2a4520f4b3d85dfe8199dd8c5d6853cc32dff2c1f00"),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    width: 150,
                    child: const Center(
                      child: Text(
                        "Salma Boutine",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 150,
                    child: Center(
                      child: Text(
                        "Bonjour, je suis salma! je peux vous aider avec vos taches ménageres.",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.black45),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.star,
                            color: Color.fromARGB(255, 255, 215, 16)),
                        Icon(Icons.star,
                            color: Color.fromARGB(255, 255, 215, 16)),
                        Icon(Icons.star,
                            color: Color.fromARGB(255, 255, 215, 16)),
                        Icon(Icons.star,
                            color: Color.fromARGB(255, 255, 215, 16)),
                        Icon(Icons.star, color: Colors.grey),
                      ],
                    ),
                  ),
                  TextButton(onPressed: () {}, child: const Text("Consulter")),
                  const SizedBox(height: 5)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
