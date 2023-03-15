// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:maidit/widgets/Bloc/FavoriteBloc.dart';

import '../model/MaidModel.dart';

class Favorites extends StatefulWidget {
  final List<Maid> maids; //TODO: change this to savedmaids
  const Favorites({super.key, required this.maids});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  bool _Searchpressed = false;
  final TextEditingController _searchController = TextEditingController();

  void _handleSearch(String query) {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            FavoriteBloc(
              maid: widget.maids[0],
            ),
          ],
        ));
  }
}
