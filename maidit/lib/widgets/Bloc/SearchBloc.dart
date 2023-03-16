// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../Pages/Profil/MaidProfil.dart';
import '../../model/MaidModel.dart';
import '../../model/UserFirebaseService.dart';
import '../RatingStars.dart';

class SearchBloc extends StatefulWidget {
  final Maid maid;
  const SearchBloc({super.key, required this.maid});

  @override
  State<SearchBloc> createState() => _SearchBlocState();
}

class _SearchBlocState extends State<SearchBloc> {
  bool _isFavorite = false;

  Future<void> _checkIfFavorite() async {
    UserFirebaseService usr = UserFirebaseService();
    bool isFavorite = await usr.isMaidFavorite(widget.maid.id);
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  Future<void> addToFavorites() async {
    UserFirebaseService usr = UserFirebaseService();
    if (_isFavorite) {
      await usr.updateUserRemoveFavorite(widget.maid.id);
    } else {
      await usr.updateUserAddFavorite(widget.maid.id);
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

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
              icon: _isFavorite
                  ? const Icon(Icons.bookmark)
                  : const Icon(Icons.bookmark_border),
              onPressed: () {
                setState(() {
                  _isFavorite != _isFavorite;
                });
                addToFavorites();
              },
            ),
          ),
          Positioned.fill(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.maid.photo!),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 6, child: SizedBox()),
                    SizedBox(
                      width: 150,
                      child: Text(
                        "${widget.maid.nom} ${widget.maid.prenom}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      widget.maid.tags![0],
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black45),
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        widget.maid.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 9, 43, 104)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15),
                      child: RatingStars(
                          rating: widget.maid.rating,
                          nbrRating: widget.maid.nbrRating,
                          withNumber: true),
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
