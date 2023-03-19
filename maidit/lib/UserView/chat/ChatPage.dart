// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers, deprecated_member_use, library_prefixes

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maidit/model/MaidModel.dart';
import 'package:maidit/model/UserMessages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/UserFirebaseService.dart';
import 'ChatBubble.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class ChatPage extends StatefulWidget {
  final Maid maid;
  const ChatPage({
    super.key,
    required this.maid,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  List<UserMessages> messages = [];
  final ScrollController _controller = ScrollController();
  String uid = '';

// This is what you're looking for!
  void _scrollDown() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
  }

  _saveToMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserFirebaseService usr = UserFirebaseService();
    usr.updateUserAddMessage(UserMessages(
        message: _textController.text,
        dateTime: DateTime.now(),
        userId: prefs.getString('uid')!,
        recipientId: widget.maid.id));
    setState(() {
      _textController.clear();
    });
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserFirebaseService usr = UserFirebaseService();
    List<UserMessages>? usermsg = await usr.getUserMessages();
    List<UserMessages>? _usermsg = [];
    for (var m in usermsg) {
      if ((m.recipientId == widget.maid.id &&
              m.userId == prefs.getString('uid')!) ||
          (m.recipientId == prefs.getString('uid')! &&
              m.userId == widget.maid.id)) {
        _usermsg.add(m);
      }
    }
    setState(() {
      uid = prefs.getString('uid')!;
      messages = _usermsg;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    Timer(const Duration(seconds: 1), _scrollDown);
  }

  bool _isUserSender(UserMessages message) {
    if (message.recipientId != widget.maid.id) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final sortedMessages = messages.toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: ClipOval(
                child: Image.network(
                  widget.maid.photo!,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                  "${widget.maid.nom.replaceFirst(widget.maid.nom.characters.first, widget.maid.nom.characters.first.toUpperCase())} ${widget.maid.prenom.replaceFirst(widget.maid.prenom.characters.first, widget.maid.prenom.characters.first.toUpperCase())}"),
            ),
          ],
        ),
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
            icon: const Icon(Icons.phone),
            onPressed: () {
              UrlLauncher.launch("tel:+212${widget.maid.phone.toString()}");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            getUserData();
            return Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 80, top: 10),
              child: ListView.builder(
                controller: _controller,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return ChatBubble(
                    message: message.message,
                    isSentByMe: _isUserSender(message),
                    date: message.dateTime,
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey[100],
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(255, 239, 31, 118)),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.mic,
                            size: 20,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: TextField(
                      controller: _textController,
                      maxLines: null,
                      onTap: () {
                        _scrollDown();
                      },
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        hintText: 'Entrer votre message',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10, right: 10),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          _saveToMessages();
                          _scrollDown();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Color.fromARGB(255, 0, 105, 242),
                        )),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
