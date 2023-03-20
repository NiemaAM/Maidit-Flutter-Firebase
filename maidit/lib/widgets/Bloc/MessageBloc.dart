// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:maidit/model/UserMessages.dart';

import '../../UserView/chat/ChatPage.dart';
import '../../model/MaidModel.dart';

class MessageBloc extends StatefulWidget {
  final Maid maid;
  final UserMessages message;
  const MessageBloc({super.key, required this.maid, required this.message});

  @override
  State<MessageBloc> createState() => _MessageBlocState();
}

class _MessageBlocState extends State<MessageBloc> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatPage(maid: widget.maid)),
        );
      },
      child: Container(
        height: 80,
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              top: 15,
              right: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.phone,
                  size: 25,
                  color: Color.fromARGB(255, 0, 105, 242),
                ),
                onPressed: () {
                  // handle icon press
                },
              ),
            ),
            Positioned(
              top: 32,
              right: 55,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 239, 31, 118),
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: const Text(
                  '1', //TODO: Change this data
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned.fill(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 5, bottom: 5),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(widget.maid.photo!),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(child: SizedBox()),
                      SizedBox(
                        width: 150,
                        child: Text(
                          "${widget.maid.nom.replaceFirst(widget.maid.nom.characters.first, widget.maid.nom.characters.first.toUpperCase())} ${widget.maid.prenom.replaceFirst(widget.maid.prenom.characters.first, widget.maid.prenom.characters.first.toUpperCase())}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          widget.message.recipientId == widget.maid.id
                              ? "Vous: ${widget.message.message}"
                              : widget.message.message,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black45),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
