// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final DateTime date;
  final bool isSentByMe;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isSentByMe,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: isSentByMe
                      ? const Color.fromARGB(255, 239, 31, 118)
                      : Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isSentByMe ? 20.0 : 0.0),
                    topRight: Radius.circular(isSentByMe ? 0.0 : 20.0),
                    bottomLeft: const Radius.circular(20.0),
                    bottomRight: const Radius.circular(20.0),
                  ),
                ),
                child: SizedBox(
                  width: message.length.toDouble() <= 20
                      ? message.length.toDouble() * 9
                      : message.length.toDouble() <= 50
                          ? message.length.toDouble() * 5
                          : message.length.toDouble() <= 80
                              ? message.length.toDouble() * 2
                              : message.length.toDouble() * 1.5,
                  child: Text(
                    message,
                    maxLines: null,
                    style: TextStyle(
                      color: isSentByMe ? Colors.white : Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                )),
          ],
        ),
        Align(
            alignment:
                isSentByMe ? Alignment.bottomRight : Alignment.bottomLeft,
            child: Text(
              "${date.hour}:${date.minute}",
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ))
      ],
    );
  }
}
