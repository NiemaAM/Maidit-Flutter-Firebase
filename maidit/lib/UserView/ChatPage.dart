// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../model/MaidModel.dart';
import '../model/UserModel.dart';

class ChatPage extends StatefulWidget {
  final Maid maid;
  final User user;
  const ChatPage({super.key, required this.maid, required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text("${widget.maid.nom} to ${widget.user.nom}"),
        ));
  }
}
