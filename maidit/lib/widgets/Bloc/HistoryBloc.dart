// ignore_for_file: file_names

import 'package:flutter/material.dart';

class HistoryBloc extends StatefulWidget {
  const HistoryBloc({super.key});

  @override
  State<HistoryBloc> createState() => _HistoryBlocState();
}

class _HistoryBlocState extends State<HistoryBloc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12, width: 0.5)),
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-photo/pretty-smiling-joyfully-female-with-fair-hair-dressed-casually-looking-with-satisfaction_176420-15187.jpg?w=1060&t=st=1678653484~exp=1678654084~hmac=cc0aaa0057aa2056f47cc2a4520f4b3d85dfe8199dd8c5d6853cc32dff2c1f00"),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 6, child: SizedBox()),
                    const SizedBox(
                      width: 150,
                      child: Text(
                        "Salma Boutine",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text(
                      "Service",
                      style: TextStyle(fontSize: 14, color: Colors.black45),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 7, bottom: 7),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 239, 31, 118),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 8, right: 8),
                            child: Text(
                              "Etat de Service en cours",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    const Text(
                      "Date",
                      style: TextStyle(
                          fontSize: 14, color: Color.fromARGB(255, 9, 43, 104)),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Voir le profil",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 12),
                        )),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
