// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

import '../model/MaidFirebaseService.dart';
import '../model/MaidModel.dart';
import '../widgets/Bloc/SearchBloc.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _Searchpressed = false;
  bool _Filterpressed = false;
  final TextEditingController _searchController = TextEditingController();
  List<Maid> allmaids = [];

  Future<void> getAllMaids() async {
    MaidFirebaseService md = MaidFirebaseService();
    List<Maid> _allmaids = await md.getAllMaids();
    setState(() {
      allmaids = _allmaids;
      _searchResults = _allmaids;
    });
  }

  List<Maid> _searchResults = [];
  void _handleSearch(String query) {
    setState(() {
      _searchResults = allmaids
          .where((maid) => maid.tags!.any((tag) =>
              tag.toLowerCase().contains(query.toLowerCase()) ||
              maid.nom.toLowerCase().contains(query.toLowerCase()) ||
              maid.prenom.toLowerCase().contains(query.toLowerCase()) ||
              maid.description.toLowerCase().contains(query.toLowerCase())))
          .toList();
    });
  }

  void _handleFilter(String service, String gender, DateTime date) {
    setState(() {
      _searchResults = allmaids
          .where((maid) => maid.tags!.any((tag) =>
              tag.toLowerCase().contains(service.toLowerCase()) &&
              maid.genre.toLowerCase().contains(gender.toLowerCase()) &&
              !maid.events!.any((event) =>
                  event.year == date.year &&
                  event.month == date.month &&
                  event.day == date.day)))
          .toList();
    });
  }

  String? selectedGender;
  String? selectedService;
  DateTime? selectedDate;

  final List<String> genderList = ['Femme', 'Homme'];
  final List<String> serviceList = [
    'Cuisine',
    'Ménage',
    'Babysitting',
    'Nettoyage',
    'Rangement'
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 60)));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllMaids();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: _Searchpressed
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
                    _Filterpressed = !_Filterpressed;
                  });
                },
                icon: const Icon(Icons.tune)),
            IconButton(
                onPressed: () {
                  setState(() {
                    _Searchpressed = !_Searchpressed;
                  });
                },
                icon: const Icon(Icons.search)),
          ],
        ),
        body: Stack(
          children: [
            allmaids.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : _searchResults.isNotEmpty
                    ? ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          return SearchBloc(maid: _searchResults[index]);
                        },
                      )
                    : const Center(
                        child: Text("Aucun résultat trouvé"),
                      ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              top: _Filterpressed ? 0 : -500.0,
              left: 0,
              right: 0,
              child: Container(
                height: 310,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Container(
                  padding:
                      const EdgeInsets.only(top: 30.0, right: 10, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            labelText: 'Genre',
                            border: OutlineInputBorder()),
                        value: selectedGender,
                        items: genderList
                            .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ))
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGender = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            labelText: 'Service',
                            border: OutlineInputBorder()),
                        value: selectedService,
                        items: serviceList
                            .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ))
                            .toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedService = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 16.0),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: InputDecorator(
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 0),
                            ),
                            labelText: selectedDate == null ? '' : 'Date',
                            border: const OutlineInputBorder(),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                  selectedDate != null
                                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                                      : 'Date',
                                  style: selectedDate != null
                                      ? null
                                      : const TextStyle(
                                          fontSize: 16, color: Colors.black54)),
                              const Icon(
                                Icons.calendar_today,
                                size: 18,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: TextButton(
                                onPressed: () {
                                  _handleFilter(
                                      selectedService ?? '',
                                      selectedGender ?? '',
                                      selectedDate ?? DateTime(0, 0, 0));
                                  setState(() {
                                    _Filterpressed = false;
                                  });
                                },
                                child: const Text("Valider")),
                          ),
                          const Expanded(child: SizedBox()),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    selectedDate = null;
                                    selectedGender = null;
                                    selectedService = null;
                                  });
                                },
                                child: const Text(
                                  "Annuler",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 239, 31, 118)),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
