// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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

  List<String> _getStringsForDay(DateTime day) {
    List<String> selectedDayEvents = widget.user.events![day] ?? [];
    return selectedDayEvents;
  }

  @override
  void initState() {
    super.initState();
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
                            "${widget.user.nom} ${widget.user.prenom}",
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
                  firstDay: DateTime.now().subtract(const Duration(days: 60)),
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
