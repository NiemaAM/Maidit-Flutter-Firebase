// ignore_for_file: file_names, non_constant_identifier_names

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
  List<Maid> historyMaids = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<UserMessages> UserMessage = [];
  DocumentSnapshot? snapshot;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Conversations"),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios, // replace with your desired icon
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_auth.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData ||
                snapshot.data!['messages'] == null ||
                snapshot.data!['messages'].isEmpty) {
              return const Center(child: Text("Auccun Message"));
            } else {
              List<Map<String, dynamic>> messagesMapList =
                  List<Map<String, dynamic>>.from(snapshot.data!['messages']);
              List<UserMessages> messagesList = messagesMapList
                  .map((MessageMap) => UserMessages(
                      dateTime:
                          DateTime.parse(MessageMap['dateTime'].toString()),
                      message: MessageMap['message'].toString(),
                      userId: MessageMap['userId'].toString(),
                      recipientId: MessageMap['recipientId'].toString()))
                  .toList();
              return FutureBuilder<List<Maid>>(
                  future: MaidFirebaseService().getMaidsByIds(
                      messagesList.map((h) => h.recipientId).toSet().toList()),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Maid>> maidSnapshot) {
                    if (maidSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (!maidSnapshot.hasData ||
                        maidSnapshot.data!.isEmpty) {
                      return const Center(child: Text("Aucun Message"));
                    } else {
                      List<Maid> historyMaids =
                          maidSnapshot.data!.toSet().toList();
                      List<UserMessages> lastMessages = [];
                      for (var maid in historyMaids) {
                        var lastMessage = messagesList.lastWhere(
                            (message) =>
                                (message.recipientId == maid.id &&
                                    message.userId == _auth.currentUser!.uid) ||
                                (message.userId == maid.id &&
                                    message.recipientId ==
                                        _auth.currentUser!.uid),
                            orElse: () => UserMessages(
                                dateTime: DateTime.now(),
                                message: '',
                                recipientId: '',
                                userId: ''));
                        lastMessages.add(lastMessage);
                      }

                      return Column(
                        children: [
                          historyMaids.isNotEmpty
                              ? Expanded(
                                  child: ListView.builder(
                                    itemCount: historyMaids.length,
                                    itemBuilder: (context, index) {
                                      return MessageBloc(
                                        maid: historyMaids[index],
                                        message: lastMessages[index],
                                      );
                                    },
                                  ),
                                )
                              : const Expanded(
                                  child: Center(
                                      child: Text("Aucun résultat trouvé")),
                                )
                        ],
                      );
                    }
                  });
            }
          },
        ));
  }
}
