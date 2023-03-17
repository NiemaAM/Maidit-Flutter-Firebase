// ignore_for_file: file_names, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maidit/widgets/Bloc/FavoriteBloc.dart';
import '../../Controller/MaidFirebaseService.dart';
import '../model/MaidModel.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  bool _Searchpressed = false;
  final TextEditingController _searchController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List list = [];
  DocumentSnapshot? snapshot;
  List<Maid> savedmaids = [];
  String _dataState = "is loading";

  //Load savedMaids
  Future<void> bookmark() async {
    User? currentUser = _auth.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    setState(() {
      list = (snapshot.data() as dynamic)['savedMaids'];
    });
    if (list.isEmpty) {
      setState(() {
        _dataState = "no data found";
      });
    } else {
      List<String> toString = [];
      for (var m in list) {
        toString.add(m);
      }
      MaidFirebaseService md = MaidFirebaseService();
      List<Maid> _savedmaids = await md.getMaidsByIds(toString);
      setState(() {
        savedmaids = _savedmaids.reversed.toList();
        _searchResults = _savedmaids;
        if (_savedmaids.isEmpty) {
          _dataState = "no data found";
        } else {
          _dataState = "data found";
        }
      });
    }
  }

  List<Maid> _searchResults = [];
  void _handleSearch(String query) {
    setState(() {
      _searchResults = savedmaids
          .where((maid) => maid.tags!.any((tag) =>
              tag.toLowerCase().contains(query.toLowerCase()) ||
              maid.nom.toLowerCase().contains(query.toLowerCase()) ||
              maid.prenom.toLowerCase().contains(query.toLowerCase()) ||
              maid.description.toLowerCase().contains(query.toLowerCase())))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    bookmark();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: _Searchpressed
              ? TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Rechercher un profil',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: _handleSearch,
                  controller: _searchController,
                )
              : const Text("Rechercher"),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _Searchpressed = !_Searchpressed;
                    _searchController.clear();
                    _handleSearch('');
                  });
                },
                icon: const Icon(Icons.search)),
          ],
        ),
        body: _dataState == "is loading"
            ? const Center(child: CircularProgressIndicator())
            : _dataState == "data found"
                ? _searchResults.isNotEmpty
                    ? ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          return FavoriteBloc(maid: _searchResults[index]);
                        },
                      )
                    : const Center(
                        child: Text("Aucun résultat trouvé"),
                      )
                : const Center(
                    child: Text("Auccun Favori"),
                  ));
  }
}
