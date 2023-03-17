// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:maidit/UserView/MaidPages/MaidProfil.dart';
import '../../Controller/UserFirebaseService.dart';
import '../../model/MaidModel.dart';
import '../RatingStars.dart';

class SuggestionBloc extends StatefulWidget {
  final Maid maid;
  const SuggestionBloc({super.key, required this.maid});

  @override
  State<SuggestionBloc> createState() => _SuggestionBlocState();
}

class _SuggestionBlocState extends State<SuggestionBloc> {
  bool _isFavorite = false;
  bool _isVisible = true;

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

  Future<void> _navigateToSecondPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MaidProfil(maid: widget.maid),
      ),
    );
    if (result != null) {
      _checkIfFavorite();
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return !_isVisible
        ? const SizedBox()
        : Center(
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
                        setState(() {
                          _isVisible = false;
                        });
                      },
                    ),
                  ),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 25),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(widget.maid.photo!),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          width: 150,
                          child: Center(
                            child: Text(
                              "${widget.maid.nom.replaceFirst(widget.maid.nom.characters.first, widget.maid.nom.characters.first.toUpperCase())} ${widget.maid.prenom.replaceFirst(widget.maid.nom.characters.first, widget.maid.nom.characters.first.toUpperCase())}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Center(
                            child: Text(
                              widget.maid.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black45),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          child: RatingStars(
                              rating: widget.maid.rating,
                              nbrRating: widget.maid.nbrRating,
                              withNumber: false),
                        ),
                        TextButton(
                            onPressed: () {
                              _navigateToSecondPage();
                            },
                            child: const Text("Consulter")),
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
