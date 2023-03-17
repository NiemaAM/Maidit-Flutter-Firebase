// ignore_for_file: file_names, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maidit/widgets/Bloc/HistoryBloc.dart';
import '../../Controller/MaidFirebaseService.dart';
import '../model/MaidModel.dart';
import '../model/UserHistory.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool _searchPressed = false;
  final TextEditingController _searchController = TextEditingController();
  List<Maid> historyMaids = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<UserHistory> userHistory = [];
  DocumentSnapshot? snapshot;
  String _dataState = "is loading";

  Future<void> getHistoryMaids() async {
    User? currentUser = _auth.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    List<UserHistory> historyList = [];
    if (snapshot.exists && snapshot['history'] != null) {
      final historyMapList =
          List<Map<String, dynamic>>.from(snapshot['history']);
      historyList = historyMapList
          .map((historyMap) => UserHistory(
              maidId: historyMap['maidId'].toString(),
              service: historyMap['service'].toString(),
              serviceState: int.parse(historyMap['serviceState'].toString()),
              serviceDate:
                  DateTime.parse(historyMap['serviceDate'].toString())))
          .toList();
    }

    MaidFirebaseService md = MaidFirebaseService();
    List<Maid> _historyMaids =
        await md.getMaidsByIds(historyList.map((h) => h.maidId!).toList());

    List<Maid> resultHistory = [];
    for (var h in historyList) {
      for (var m in _historyMaids) {
        if (m.id == h.maidId) {
          resultHistory.add(m);
        }
      }
    }

    setState(() {
      historyMaids = resultHistory;
      _searchResults = resultHistory;
      userHistory.addAll(historyList.reversed.toList());
      if (resultHistory.isEmpty) {
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
          automaticallyImplyLeading: false,
          title: _searchPressed
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
                          return HistoryBloc(
                            maid: _searchResults[index],
                            history: userHistory[index],
                          );
                        },
                      )
                    : const Center(
                        child: Text("Aucun résultat trouvé"),
                      )
                : const Center(
                    child: Text("Auccun Historique"),
                  ));
  }
}
