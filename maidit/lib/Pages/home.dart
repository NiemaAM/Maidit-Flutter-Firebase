import 'package:flutter/material.dart';
import 'package:maidit/Pages/Favorites.dart';
import 'package:maidit/Pages/History.dart';
import 'package:maidit/Pages/Profil.dart';
import 'package:maidit/Pages/Search.dart';
import 'package:maidit/Pages/Suggestions.dart';

import '../model/MaidModel.dart';
import '../model/UserModel.dart';
import 'Login and SignIn/LogIn.dart';
import 'Messages.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isSuggestions = true;
  bool _isSearch = false;
  bool _isProfil = false;
  bool _isHistory = false;
  bool _isFavorits = false;

  // ignore: prefer_final_fields
  late List<Widget> _pages = [
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
    const SizedBox()
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          _isSuggestions = true;
          _isSearch = false;
          _isProfil = false;
          _isHistory = false;
          _isFavorits = false;
          break;
        case 1:
          _isSuggestions = false;
          _isSearch = true;
          _isProfil = false;
          _isHistory = false;
          _isFavorits = false;
          break;
        case 2:
          _isSuggestions = false;
          _isSearch = false;
          _isProfil = true;
          _isHistory = false;
          _isFavorits = false;
          break;
        case 3:
          _isSuggestions = false;
          _isSearch = false;
          _isProfil = false;
          _isHistory = true;
          _isFavorits = false;
          break;
        case 4:
          _isSuggestions = false;
          _isSearch = false;
          _isProfil = false;
          _isHistory = false;
          _isFavorits = true;
          break;
        default:
      }
    });
  }

  User user = User(
    id: '12345',
    nom: 'Ghita',
    prenom: 'Moslih',
    phone: 555555555,
    ville: 'Rabat',
    adresse: '123 Avenue de France',
    registerDate: DateTime.now(),
    description:
        "Bonjour, je suis Ghita, j'ai 28 ans et je suis mére de 2 fils.",
    photo:
        "https://img.freepik.com/free-photo/close-up-beautiful-calm-attractive-young-brunette-woman-posing_295783-267.jpg?w=1060&t=st=1678717105~exp=1678717705~hmac=23931e49d182780966778b08d53c1ef8ade4337ee6f7a1bface7d52f0e00ada8",
    tags: ['Cuisine', 'Ménage', 'Nettoyage'],
    events: {
      DateTime.utc(2023, 3, 14).subtract(const Duration(days: 1)): ['String 1'],
      DateTime.utc(2023, 3, 14).add(const Duration(days: 1)): [
        'String 4',
        'String 5',
        'String 5'
      ],
      DateTime.utc(2023, 3, 14).add(const Duration(days: 5)): ['String 6'],
      DateTime.utc(2023, 3, 14).add(const Duration(days: 10)): ['String 7'],
    },
    savedMaids: ["1", "2"],
  );

  List<Maid> maids = [
    Maid(
      id: '1',
      nom: 'Smith',
      prenom: 'Anna',
      phone: 123456789,
      ville: 'Paris',
      adresse: '123 Main Street',
      registerDate: DateTime.now(),
      description: 'I am an experienced and reliable maid.',
      photo:
          'https://img.freepik.com/free-photo/pretty-smiling-joyfully-female-with-fair-hair-dressed-casually-looking-with-satisfaction_176420-15187.jpg?w=1060&t=st=1678653484~exp=1678654084~hmac=cc0aaa0057aa2056f47cc2a4520f4b3d85dfe8199dd8c5d6853cc32dff2c1f00',
      tags: ['Cuisine', 'Ménage'],
      events: [
        DateTime.utc(2023, 3, 14).subtract(const Duration(days: 1)),
        DateTime.utc(2023, 3, 14).add(const Duration(days: 1)),
        DateTime.utc(2023, 3, 14).add(const Duration(days: 5)),
        DateTime.utc(2023, 3, 14).add(const Duration(days: 10)),
      ],
      prixMin: 10.0,
      prixMax: 20.0,
      rating: 4.5,
      nbrRating: 10,
    ),
    Maid(
      id: '2',
      nom: 'Johnson',
      prenom: 'Sarah',
      phone: 987654321,
      ville: 'New York',
      adresse: '456 Maple Ave',
      registerDate: DateTime.now(),
      description: 'I am a detail-oriented and hard-working maid.',
      photo:
          'https://img.freepik.com/free-photo/portrait-serious-confident-sassy-good-looking-woman-with-bushy-curly-hair-looks-directly-camera-stands-indoor-against-beige-background-wears-casual-jumper-human-face-expressions-concept_273609-57528.jpg?w=1060&t=st=1678834661~exp=1678835261~hmac=51b3d8a33068b26e56c2c1b47d84eb06cb3e5488fb2596a798839c2c2ca532b8',
      tags: ['Nettoyage', 'BabySiting'],
      events: [
        DateTime.utc(2023, 3, 14).subtract(const Duration(days: 3)),
        DateTime.utc(2023, 3, 14).add(const Duration(days: 2)),
        DateTime.utc(2023, 3, 14).add(const Duration(days: 7)),
      ],
      prixMin: 15.0,
      prixMax: 25.0,
      rating: 4.8,
      nbrRating: 20,
    ),
    Maid(
      id: '3',
      nom: 'Williams',
      prenom: 'Jessica',
      phone: 555555555,
      ville: 'Los Angeles',
      adresse: '789 Oak Street',
      registerDate: DateTime.now(),
      description: 'I am a friendly and efficient maid.',
      photo:
          'https://img.freepik.com/free-photo/beautiful-smiling-girl-introduce-something-holding-hand_1258-19078.jpg?w=1060&t=st=1678834702~exp=1678835302~hmac=277574d9008cd8567b2338e82c7bdc1e5e9b9d2e2897e9ce197457c483921c9b',
      tags: ['Ménage', 'Netoyage'],
      events: [
        DateTime.utc(2023, 3, 14).subtract(const Duration(days: 9)),
      ],
      prixMin: 20.0,
      prixMax: 30.0,
      rating: 4.3,
      nbrRating: 15,
    ),
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      _pages[0] = Suggestions(
        maids: maids,
      );
      _pages[1] = Search(
        maids: maids,
      );
      _pages[2] = Profil(
        user: user,
      );
      _pages[3] = History(
        maids: maids,
      );
      _pages[4] = Favorites(
        maids: maids,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _isSuggestions
            ? AppBar(
                actions: [
                  const Expanded(flex: 3, child: SizedBox()),
                  Image.asset(
                    "assets/logos/logo-white.png",
                    height: 20.0,
                    width: 80.0,
                  ),
                  const Expanded(flex: 2, child: SizedBox()),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Messages(),
                        ),
                      );
                    },
                    icon: Stack(
                      children: [
                        Container(
                            margin: const EdgeInsets.all(5),
                            child:
                                const Icon(Icons.chat_bubble_outline_outlined)),
                        Positioned(
                          top: 0,
                          right: 0,
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
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : null,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 105, 242),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: Image.network(
                          user.photo ??
                              'https://cdn-icons-png.flaticon.com/512/3177/3177440.png',
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "${user.nom} ${user.prenom}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                title: const Text('Modifier mes informations personelles'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Paramétres'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Aide'),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  'Se deconnecter',
                  style: TextStyle(color: Color.fromARGB(255, 239, 31, 118)),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LogIn(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: _pages.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(child: SizedBox()),
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: _isSuggestions
                      ? const Color.fromARGB(255, 0, 105, 242)
                      : Colors.black45,
                ),
                onPressed: () {
                  _onItemTapped(0);
                },
              ),
              const Expanded(flex: 2, child: SizedBox()),
              IconButton(
                icon: Icon(Icons.search,
                    color: _isSearch
                        ? const Color.fromARGB(255, 0, 105, 242)
                        : Colors.black45),
                onPressed: () {
                  _onItemTapped(1);
                },
              ),
              Expanded(flex: _isProfil ? 2 : 6, child: const SizedBox()),
              IconButton(
                icon: Icon(Icons.history,
                    color: _isHistory
                        ? const Color.fromARGB(255, 0, 105, 242)
                        : Colors.black45),
                onPressed: () {
                  _onItemTapped(3);
                },
              ),
              const Expanded(flex: 2, child: SizedBox()),
              IconButton(
                icon: Icon(Icons.bookmark_add,
                    color: _isFavorits
                        ? const Color.fromARGB(255, 0, 105, 242)
                        : Colors.black45),
                onPressed: () {
                  _onItemTapped(4);
                },
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _isProfil
            ? null
            : FloatingActionButton(
                backgroundColor: Colors.transparent,
                onPressed: () {
                  _onItemTapped(2);
                },
                child: CircleAvatar(
                  radius: 50.0,
                  child: ClipOval(
                    child: Image.network(
                      user.photo ??
                          'https://cdn-icons-png.flaticon.com/512/3177/3177440.png',
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                ),
              ));
  }
}
