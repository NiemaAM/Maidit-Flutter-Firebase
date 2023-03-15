// ignore_for_file: file_names

class User {
  String id = '';
  String nom = '';
  String prenom = '';
  int phone = 000000000;
  String? ville = '';
  String? adresse = '';
  DateTime registerDate = DateTime.now();
  String description = '';
  String? photo = 'https://cdn-icons-png.flaticon.com/512/3177/3177440.png';
  List<String>? tags = [];
  Map<DateTime, List<String>?>? events = {};
  List<String>? savedMaids = [];

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.phone,
    this.ville,
    this.adresse,
    required this.registerDate,
    required this.description,
    this.photo,
    this.tags,
    this.events,
    this.savedMaids,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      phone: json['phone'] ?? 0,
      ville: json['ville'],
      adresse: json['adresse'],
      registerDate: DateTime.tryParse(json['registerDate']) ?? DateTime.now(),
      description: json['description'] ?? '',
      photo: json['photo'],
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      events: json['events'] != null
          ? Map<DateTime, List<String>?>.fromEntries(json['events'].map(
              (key, value) => MapEntry(DateTime.tryParse(key) ?? DateTime.now(),
                  value != null ? List<String>.from(value) : null)))
          : null,
      savedMaids: json['savedMaids'] != null
          ? List<String>.from(json['savedMaids'])
          : null,
    );
  }
}
