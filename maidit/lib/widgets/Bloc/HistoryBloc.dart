// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:maidit/UserView/Map/TrackMaid.dart';
import 'package:maidit/UserView/Payement/ChooseMethode.dart';
import 'package:maidit/model/UserHistory.dart';

import '../../UserView/MaidPages/MaidProfil.dart';
import '../../UserView/chat/ChatPage.dart';
import '../../model/MaidModel.dart';

class HistoryBloc extends StatefulWidget {
  final Maid maid;
  final UserHistory history;
  const HistoryBloc({super.key, required this.maid, required this.history});

  @override
  State<HistoryBloc> createState() => _HistoryBlocState();
}

class _HistoryBlocState extends State<HistoryBloc> {
  int _serviceState = 0;

  Widget serviceState() {
    switch (_serviceState) {
      case -1:
        return Container(
          margin: const EdgeInsets.only(top: 7, bottom: 7),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
                child: Text(
                  'Demande rejetée',
                  style: TextStyle(color: Colors.black45),
                ),
              )),
        );
      case 0:
        return Container(
          margin: const EdgeInsets.only(top: 7, bottom: 7),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 239, 31, 118),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
                child: Text(
                  'Demande envoyée',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        );
      case 1:
        return Container(
          margin: const EdgeInsets.only(top: 7, bottom: 7),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 105, 242),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
                child: Text(
                  'Demande acceptée',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        );
      case 2:
        return Container(
          margin: const EdgeInsets.only(top: 7, bottom: 7),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 3, 23, 136),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
                child: Text(
                  'Service en cours',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        );
      case 3:
        return Container(
          margin: const EdgeInsets.only(top: 7, bottom: 7),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 12, 157, 7),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
                child: Text(
                  'Service terminé',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        );
      default:
        return Container(
          margin: const EdgeInsets.only(top: 7, bottom: 7),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 239, 31, 118),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
                child: Text(
                  '?',
                  style: TextStyle(color: Colors.white),
                ),
              )),
        );
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _serviceState = widget.history.serviceState!.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12, width: 0.5)),
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.maid.photo!),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 6, child: SizedBox()),
                    SizedBox(
                      width: 150,
                      child: Text(
                        "${widget.maid.nom} ${widget.maid.prenom}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      widget.history.service!,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black45),
                    ),
                    serviceState(),
                    Text(
                      "Le ${widget.history.serviceDate!.day}/${widget.history.serviceDate!.month}/${widget.history.serviceDate!.year} à ${widget.history.serviceDate!.hour}:${widget.history.serviceDate!.minute}",
                      style: const TextStyle(
                          fontSize: 14, color: Color.fromARGB(255, 9, 43, 104)),
                    ),
                    TextButton(
                        onPressed: () {
                          switch (_serviceState) {
                            case -1:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MaidProfil(maid: widget.maid),
                                ),
                              );
                              break;
                            case 0:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatPage(maid: widget.maid),
                                ),
                              );
                              break;
                            case 1:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatPage(maid: widget.maid),
                                ),
                              );
                              break;
                            case 2:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TrackMaid(maid: widget.maid),
                                ),
                              );
                              break;
                            case 3:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChooseMethode(maid: widget.maid),
                                ),
                              );
                              break;
                            default:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MaidProfil(maid: widget.maid),
                                ),
                              );
                          }
                        },
                        child: Text(
                          _serviceState == -1
                              ? "Voir le profil"
                              : _serviceState == 0 || _serviceState == 1
                                  ? "Voir ma demande"
                                  : _serviceState == 2
                                      ? "Suivre le service"
                                      : _serviceState == 3
                                          ? "Proceder au payement"
                                          : "Voir le profil",
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 12),
                        )),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
