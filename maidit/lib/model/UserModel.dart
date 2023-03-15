// ignore_for_file: file_names

class User {
  String id = '';
  String nom = '';
  String prenom = '';
  String genre = '';
  String email = '';
  int phone = 000000000;
  String? ville = '';
  String? adresse = '';
  DateTime registerDate = DateTime.now();
  String description = '';
  String? photo = 'https://cdn-icons-png.flaticon.com/512/3177/3177440.png';
  List<String>? tags = [];
  Map<DateTime, List<String>?>? events = {};
  List<String>? savedMaids = [];
  Map<String /*maid id*/, Map<int /*state*/, DateTime /*date*/ >>? history = {};
  Map<Map<String /*maid id*/, Map<DateTime /*date*/, String /*message*/ >>,
          Map<String /*user id*/, Map<DateTime /*date*/, String /*message*/ >>>?
      messages = {};

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.genre,
    required this.email,
    required this.phone,
    this.ville,
    this.adresse,
    required this.registerDate,
    required this.description,
    this.photo,
    this.tags,
    this.events,
    this.savedMaids,
    this.history,
    this.messages,
  });

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'prenom': prenom,
      'genre': genre,
      'email': email,
      'phone': phone,
      'ville': ville,
      'adresse': adresse,
      'registerDate': registerDate.millisecondsSinceEpoch,
      'description': description,
      'photo': photo,
      'tags': tags,
      'events': events?.map((key, value) => MapEntry(
            key.millisecondsSinceEpoch,
            value,
          )),
      'savedMaids': savedMaids,
      'history': history?.map((key, value) => MapEntry(
            key,
            value.map((key, value) => MapEntry(
                  key,
                  value.millisecondsSinceEpoch,
                )),
          )),
      'messages': messages?.map((key, value) => MapEntry(
            key.map((key, value) => MapEntry(
                  key,
                  value.map((key, value) => MapEntry(
                        key.millisecondsSinceEpoch,
                        value,
                      )),
                )),
            value.map((key, value) => MapEntry(
                  key,
                  value.map((key, value) => MapEntry(
                        key.millisecondsSinceEpoch,
                        value,
                      )),
                )),
          )),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      genre: map['genre'],
      email: map['email'],
      phone: map['phone'],
      ville: map['ville'],
      adresse: map['adresse'],
      registerDate: DateTime.fromMillisecondsSinceEpoch(map['registerDate']),
      description: map['description'],
      photo: map['photo'],
      tags: List<String>.from(map['tags']),
      events: map['events'] != null
          ? Map<DateTime, List<String>?>.fromEntries(map['events'].map((entry) {
              return MapEntry<DateTime, List<String>>(
                DateTime.fromMillisecondsSinceEpoch(entry.key),
                entry.value != null ? List<String>.from(entry.value) : [],
              );
            }))
          : null,
      savedMaids: List<String>.from(map['savedMaids']),
      history: map['history'] != null
          ? Map<String, Map<int, DateTime>>.fromEntries(map['history'].map(
              (entry) {
                return MapEntry<String, Map<int, DateTime>>(
                  entry.key,
                  Map<int, DateTime>.fromEntries(entry.value.map((entry) {
                    return MapEntry<int, DateTime>(
                      entry.key,
                      DateTime.fromMillisecondsSinceEpoch(entry.value),
                    );
                  })),
                );
              },
            ))
          : null,
      messages: map['messages'] != null
          ? Map<Map<String, Map<DateTime, String>>,
              Map<String, Map<DateTime, String>>>.fromEntries(
              map['messages'].map(
                (entry) {
                  return MapEntry<Map<String, Map<DateTime, String>>,
                      Map<String, Map<DateTime, String>>>(
                    Map<String, Map<DateTime, String>>.fromEntries(
                        entry.key.map((entry) {
                      return MapEntry<String, Map<DateTime, String>>(
                        entry.key,
                        Map<DateTime, String>.fromEntries(
                            entry.value.map((entry) {
                          return MapEntry<DateTime, String>(
                            DateTime.fromMillisecondsSinceEpoch(entry.key),
                            entry.value,
                          );
                        })),
                      );
                    })),
                    Map<String, Map<DateTime, String>>.fromEntries(
                        entry.value.map((entry) {
                      return MapEntry<String, Map<DateTime, String>>(
                        entry.key,
                        Map<DateTime, String>.fromEntries(
                            entry.value.map((entry) {
                          return MapEntry<DateTime, String>(
                            DateTime.fromMillisecondsSinceEpoch(entry.key),
                            entry.value,
                          );
                        })),
                      );
                    })),
                  );
                },
              ),
            )
          : null,
    );
  }
}
