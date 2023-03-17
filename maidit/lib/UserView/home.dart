// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maidit/UserView/Favorites.dart';
import 'package:maidit/UserView/History.dart';
import 'package:maidit/UserView/Profil.dart';
import 'package:maidit/UserView/Search.dart';
import 'package:maidit/UserView/Suggestions.dart';

import '../../Controller/Authentication.dart';
import '../Controller/UserFirebaseService.dart';
import '../model/UserModel.dart';
import 'Login and SignIn/LogIn.dart';
import 'Messages.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({
    super.key,
    required this.user,
  });

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
    const Suggestions(),
    const Search(),
    const Center(child: CircularProgressIndicator()),
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

  logOutAccount() async {
    Authentication auth = Authentication();
    auth.logOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LogIn(),
      ),
    );
  }

  User? user;
  Future<void> getUserData() async {
    UserFirebaseService usr = UserFirebaseService();
    User? _user = await usr.getUser();
    setState(() {
      user = _user;
      _pages[2] = Profil(
        user: _user!,
      );
      userDataStream = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.id)
          .snapshots();
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>>? userDataStream;
  @override
  void initState() {
    super.initState();
    setState(() {
      userDataStream = null;
      user = widget.user;
      _pages[2] = Profil(
        user: widget.user,
      );
    });
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (userDataStream == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: userDataStream,
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          }

          final usr = User.fromMap(snapshot.data!.data()!);
          return usr.id == ''
              ? const Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(child: CircularProgressIndicator()))
              : Scaffold(
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
                                      child: const Icon(
                                          Icons.chat_bubble_outline_outlined)),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 239, 31, 118),
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
                                    usr.photo!,
                                    fit: BoxFit.cover,
                                    width: 100.0,
                                    height: 100.0,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "${usr.nom.replaceFirst(usr.nom.characters.first, usr.nom.characters.first.toUpperCase())} ${usr.prenom.replaceFirst(usr.prenom.characters.first, usr.prenom.characters.first.toUpperCase())}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          title: const Text(
                              'Modifier mes informations personelles'),
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
                            style: TextStyle(
                                color: Color.fromARGB(255, 239, 31, 118)),
                          ),
                          onTap: () {
                            logOutAccount();
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
                        Expanded(
                            flex: _isProfil ? 2 : 6, child: const SizedBox()),
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
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
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
                                usr.photo!,
                                fit: BoxFit.cover,
                                width: 100.0,
                                height: 100.0,
                              ),
                            ),
                          ),
                        ));
        },
      );
    }
  }
}
