import 'package:flutter/material.dart';
import 'package:maidit/Pages/Favorites.dart';
import 'package:maidit/Pages/History.dart';
import 'package:maidit/Pages/Profil.dart';
import 'package:maidit/Pages/Search.dart';
import 'package:maidit/Pages/Suggestions.dart';

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
  String avatar =
      "https://img.freepik.com/free-photo/close-up-beautiful-calm-attractive-young-brunette-woman-posing_295783-267.jpg?w=1060&t=st=1678717105~exp=1678717705~hmac=23931e49d182780966778b08d53c1ef8ade4337ee6f7a1bface7d52f0e00ada8";

  // ignore: prefer_final_fields
  late List<Widget> _pages = [
    const Suggestions(),
    const Search(),
    const Profil(),
    const History(),
    const Favorites()
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
                              '1', //TODO: Change this data
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
                          avatar,
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Ghita Moslih",
                        style: TextStyle(color: Colors.white),
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
                      avatar,
                      fit: BoxFit.cover,
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                ),
              ));
  }
}
