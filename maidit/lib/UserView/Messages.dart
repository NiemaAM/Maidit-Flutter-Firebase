// ignore_for_file: file_names, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maidit/model/UserMessages.dart';

import '../Controller/MaidFirebaseService.dart';
import '../model/MaidModel.dart';
import '../widgets/Bloc/MessageBloc.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  bool _searchPressed = false;
  final TextEditingController _searchController = TextEditingController();
  List<Maid> historyMaids = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<UserMessages> UserMessage = [];
  DocumentSnapshot? snapshot;
  String _dataState = "is loading";

  Future<void> getHistoryMaids() async {
    User? currentUser = _auth.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    List<UserMessages> messagesList = [];
    if (snapshot.exists && snapshot['messages'] != null) {
      final messagesMapList =
          List<Map<String, dynamic>>.from(snapshot['messages']);
      messagesList = messagesMapList
          .map((historyMap) => UserMessages(
              dateTime: DateTime.parse(historyMap['dateTime'].toString()),
              message: historyMap['message'].toString(),
              userId: historyMap['userId'].toString(),
              recipientId: historyMap['recipientId'].toString()))
          .toList();
    }

    MaidFirebaseService md = MaidFirebaseService();
    List<Maid> _messagesMaids =
        await md.getMaidsByIds(messagesList.map((h) => h.recipientId).toList());

    setState(() {
      historyMaids = _messagesMaids;
      _searchResults = _messagesMaids;
      UserMessage.addAll(messagesList.reversed.toList());
      if (_messagesMaids.isEmpty) {
        _dataState = "no data found";
      } else {
        _dataState = "data found";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getHistoryMaids();
  }

  List<Maid> _searchResults = [];
  void _handleSearch(String query) {
    setState(() {
      _searchResults = historyMaids
          .where((maid) => maid.tags!.any((tag) =>
              tag.toLowerCase().contains(query.toLowerCase()) ||
              maid.nom.toLowerCase().contains(query.toLowerCase()) ||
              maid.prenom.toLowerCase().contains(query.toLowerCase()) ||
              maid.description.toLowerCase().contains(query.toLowerCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _searchPressed
              ? TextField(
                  autofocus: true,
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
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios, // replace with your desired icon
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _searchPressed = !_searchPressed;
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
                          return MessageBloc(
                            maid: _searchResults[index],
                            message: UserMessage[index],
                          );
                        },
                      )
                    : const Center(
                        child: Text("Aucun résultat trouvé"),
                      )
                : const Center(
                    child: Text("Auccun Message"),
                  ));
  }
}
