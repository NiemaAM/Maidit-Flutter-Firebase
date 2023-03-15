// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MessageBloc extends StatefulWidget {
  final String id;
  const MessageBloc({super.key, required this.id});

  @override
  State<MessageBloc> createState() => _MessageBlocState();
}

class _MessageBlocState extends State<MessageBloc> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO: handel tap
      },
      child: Container(
        height: 80,
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: 15,
              right: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.phone,
                  size: 25,
                  color: Color.fromARGB(255, 0, 105, 242),
                ),
                onPressed: () {
                  // handle icon press
                },
              ),
            ),
            Positioned(
              top: 32,
              right: 55,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 239, 31, 118),
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: const Text(
                  '1', //TODO: Change this data
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned.fill(
              child: Row(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          "https://img.freepik.com/free-photo/pretty-smiling-joyfully-female-with-fair-hair-dressed-casually-looking-with-satisfaction_176420-15187.jpg?w=1060&t=st=1678653484~exp=1678654084~hmac=cc0aaa0057aa2056f47cc2a4520f4b3d85dfe8199dd8c5d6853cc32dff2c1f00"),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Expanded(child: SizedBox()),
                      SizedBox(
                        width: 150,
                        child: Text(
                          "Salma Boutine",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          "Bonjour, je suis salma! je peux vous aider avec vos taches ménageres.",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 14, color: Colors.black45),
                        ),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
