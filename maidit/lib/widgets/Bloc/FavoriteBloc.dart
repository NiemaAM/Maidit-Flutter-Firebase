// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../Pages/Profil/MaidProfil.dart';
import '../../model/MaidModel.dart';
import '../RatingStars.dart';

class FavoriteBloc extends StatefulWidget {
  final Maid maid;
  const FavoriteBloc({super.key, required this.maid});

  @override
  State<FavoriteBloc> createState() => _FavoriteBlocState();
}

class _FavoriteBlocState extends State<FavoriteBloc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12, width: 0.5)),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.bookmark),
              onPressed: () {
                // handle icon press
              },
            ),
          ),
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
                    const SizedBox(
                      width: 200,
                      child: Text(
                        "Bonjour, je suis salma! je peux vous aider avec vos taches ménageres.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 9, 43, 104)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15),
                      child: const RatingStars(
                          rating: 2.7, nbrRating: 0, withNumber: false),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MaidProfil(maid: widget.maid),
                            ),
                          );
                        },
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
