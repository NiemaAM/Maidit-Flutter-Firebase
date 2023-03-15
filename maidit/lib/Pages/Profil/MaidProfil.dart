// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../model/MaidModel.dart';
import '../../widgets/RatingStars.dart';

class MaidProfil extends StatefulWidget {
  final Maid maid;
  const MaidProfil({super.key, required this.maid});

  @override
  State<MaidProfil> createState() => _MaidProfilState();
}

class _MaidProfilState extends State<MaidProfil> {
  int _selectedIndex = 0;
  final DateTime _focusedDay = DateTime.now();
  List<DateTime> events = [];

  Iterable<Widget> get tagsWidgets {
    return widget.maid.tags!.map((String tag) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 239, 31, 118),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              constraints: const BoxConstraints(
                maxHeight: 40,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 13, right: 13, top: 5, bottom: 6),
                child: Text(
                  tag,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _onMenuChange() {
    switch (_selectedIndex) {
      case 0:
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            children: tagsWidgets.toList(),
          ),
        );
      case 1:
        return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Center(
              child: Text(
                '${widget.maid.prixMin} ~ ${widget.maid.prixMax} DHS',
                style: const TextStyle(
                    color: Color.fromARGB(255, 0, 105, 242), fontSize: 18),
              ),
            ));
      case 2:
        return Column(
          children: [
            Row(
              children: const [
                Expanded(flex: 10, child: SizedBox()),
                Icon(Icons.circle, color: Color.fromARGB(255, 239, 31, 118)),
                Expanded(child: SizedBox()),
                Text("Indisponible"),
                Expanded(flex: 10, child: SizedBox()),
                Icon(Icons.circle, color: Colors.blue),
                Expanded(child: SizedBox()),
                Text("Aujourd'hui"),
                Expanded(flex: 10, child: SizedBox()),
              ],
            ),
            TableCalendar(
              locale: 'fr_FR',
              firstDay: DateTime.now().subtract(const Duration(days: 60)),
              lastDay: DateTime.now().add(const Duration(days: 60)),
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                return events.any((eventDay) => isSameDay(eventDay, day));
              },
              onFormatChanged: (format) {},
              onDaySelected: (selectedDay, focusedDay) {},
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
          ],
        );
      default:
        return const Center(child: Text("none"));
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      events = widget.maid.events!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.maid.nom} ${widget.maid.prenom}"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark))
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 170,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(widget.maid.photo!),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: SizedBox()),
                    SizedBox(
                      width: width / 2,
                      child: Text(
                        "${widget.maid.nom} ${widget.maid.prenom}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: width / 2,
                      child: Text(
                        widget.maid.description,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black45),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 15),
                      child: RatingStars(
                          rating: widget.maid.rating,
                          nbrRating: widget.maid.nbrRating,
                          withNumber: true),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              widget.maid.certified
                  ? Image.network(
                      "https://cdn-icons-png.flaticon.com/512/5733/5733819.png",
                      width: 30,
                    )
                  : const SizedBox(
                      width: 30,
                    ),
              const Expanded(child: SizedBox()),
              SizedBox(
                  width: 160,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("Contacter"))),
              const Expanded(child: SizedBox()),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text("À: ${widget.maid.ville}"),
              ),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 20),
                child: Text(
                    "Depuis le: ${widget.maid.registerDate.day}/${widget.maid.registerDate.month}/${widget.maid.registerDate.year}"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              height: 20,
              thickness: 2,
              indent: 8,
              endIndent: 8,
              color: Colors.grey[200],
            ),
          ),
          BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.cleaning_services),
                label: 'Services',
                backgroundColor: Color.fromARGB(255, 239, 31, 118),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.attach_money),
                label: 'Prix',
                backgroundColor: Color.fromARGB(255, 239, 31, 118),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timelapse),
                label: 'Temps',
                backgroundColor: Color.fromARGB(255, 239, 31, 118),
              ),
            ],
            //when an item is selected
            currentIndex: _selectedIndex,
            selectedItemColor: const Color.fromARGB(255, 239, 31, 118),
            onTap: _onItemTapped,
          ),
          _onMenuChange()
        ],
      ),
    );
  }
}
