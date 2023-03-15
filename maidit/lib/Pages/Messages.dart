// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

import '../widgets/Bloc/MessageBloc.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  bool _Searchpressed = false;
  final TextEditingController _searchController = TextEditingController();

  void _handleSearch(String query) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _Searchpressed
              ? TextField(
                  decoration: const InputDecoration(
                    hintText: 'Rechercher une personne',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white54),
                  ),
                  style: const TextStyle(color: Colors.white),
                  onChanged: _handleSearch,
                  controller: _searchController,
                )
              : const Text("Conversations"),
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
          padding: const EdgeInsets.only(top: 10),
          scrollDirection: Axis.vertical,
          children: const [
            MessageBloc(
              id: '',
            ),
            MessageBloc(
              id: '',
            ),
            MessageBloc(
              id: '',
            ),
            MessageBloc(
              id: '',
            ),
          ],
        ));
  }
}
