// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Controller/MaidFirebaseService.dart';
import '../../model/MaidModel.dart';
import '../../model/UserHistory.dart';
import '../../model/UserModel.dart';

class ViewMyProfil extends StatefulWidget {
  final User user;
  const ViewMyProfil({
    super.key,
    required this.user,
  });

  @override
  State<ViewMyProfil> createState() => _ViewMyProfilState();
}

class _ViewMyProfilState extends State<ViewMyProfil> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  bool _select = false;

  Iterable<Widget> get tagsWidgets {
    return widget.user.tags!.map((String tag) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 0, 105, 242),
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          constraints: const BoxConstraints(
            maxHeight: 40,
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 13, right: 13, top: 5, bottom: 6),
            child: Text(
              tag,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      );
    });
  }

  List<Maid> historyMaids = [];
  getMaid() async {
    List<UserHistory> historyList = [];
    MaidFirebaseService md = MaidFirebaseService();
    List<Maid> _historyMaids =
        await md.getMaidsByIds(historyList.map((h) => h.maidId!).toList());
    setState(() {
      historyMaids = _historyMaids;
    });
  }

  List<String> _getStringsForDay(DateTime day) {
    List<String> selectedDayEvents = [];
    List<UserHistory> historyList = [];
    historyList = widget.user.history!;
    for (var h in historyList) {
      if (DateTime.utc(
              h.serviceDate!.year, h.serviceDate!.month, h.serviceDate!.day) ==
          DateTime.utc(day.year, day.month, day.day)) {
        switch (h.serviceState) {
          case -1:
            selectedDayEvents
                .add("Service \"${h.service!}\" : Demande rejetée");
            break;
          case 0:
            selectedDayEvents
                .add("Service \"${h.service!}\" : Demande envoyée");
            break;
          case 1:
            selectedDayEvents
                .add("Service \"${h.service!}\" : Demande acceptée");
            break;
          case 2:
            selectedDayEvents
                .add("Service \"${h.service!}\" : Service en cours");
            break;
          case 3:
            selectedDayEvents
                .add("Service \"${h.service!}\" : Service terminé");
            break;
          default:
        }
      }
    }
    return selectedDayEvents;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                color: Colors.grey[50],
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(widget.user.photo!),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(child: SizedBox()),
                        SizedBox(
                          width: 150,
                          child: Text(
                            "${widget.user.nom.replaceFirst(widget.user.nom.characters.first, widget.user.nom.characters.first.toUpperCase())} ${widget.user.prenom.replaceFirst(widget.user.prenom.characters.first, widget.user.prenom.characters.first.toUpperCase())}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            widget.user.description,
                            maxLines: 5,
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
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Mes centres d'intérêts",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 16),
                ),
              ),
              Container(
                width: width,
                color: Colors.grey[50],
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Wrap(
                    children: tagsWidgets.toList(),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Mon agenda",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 16),
                ),
              ),
              _getStringsForDay(_selectedDay).isNotEmpty && _select
                  ? Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'Le ${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}',
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 16),
                      ),
                    )
                  : _select
                      ? Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'Le ${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year}',
                            style: const TextStyle(
                                color: Colors.black87, fontSize: 16),
                          ),
                        )
                      : const SizedBox(),
              _getStringsForDay(_selectedDay).isNotEmpty && _select
                  ? Container(
                      height: 180,
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListView.builder(
                        itemCount: _getStringsForDay(_selectedDay).length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Card(
                              child: ListTile(
                                title: Text(
                                    _getStringsForDay(_selectedDay)[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : _select
                      ? const SizedBox(
                          height: 180,
                          child: Center(
                            child: Text("Aucun événements prévus"),
                          ),
                        )
                      : const SizedBox(),
              Container(
                color: Colors.grey[50],
                child: TableCalendar(
                  locale: 'fr_FR',
                  firstDay: widget.user.registerDate,
                  lastDay: DateTime.now().add(const Duration(days: 60)),
                  focusedDay: _focusedDay,
                  calendarFormat: CalendarFormat.month,
                  eventLoader: _getStringsForDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onFormatChanged: (format) {},
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _select = true;
                    });
                  },
                  calendarStyle: CalendarStyle(
                    weekendDecoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    todayDecoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: const BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
