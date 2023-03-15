// ignore_for_file: file_names
class Maid {
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
  List<DateTime>? events = [];
  double prixMin = 0.0;
  double prixMax = 0.0;
  double rating = 0.0;
  int nbrRating = 0;
  bool certified = false;
  Map<String /*user id*/,
          Map<DateTime /*date*/, Map<double /*rating*/, String /*comment*/ >>>?
      coments = {};

  Maid({
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
    required this.prixMin,
    required this.prixMax,
    required this.rating,
    required this.nbrRating,
    required this.certified,
    this.coments,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'genre': genre,
      'email': email,
      'phone': phone,
      'ville': ville,
      'adresse': adresse,
      'registerDate': registerDate.toIso8601String(),
      'description': description,
      'photo': photo,
      'tags': tags,
      'events': events?.map((e) => e.toIso8601String()).toList(),
      'prixMin': prixMin,
      'prixMax': prixMax,
      'rating': rating,
      'nbrRating': nbrRating,
      'certified': certified,
      'comments': coments?.map((k, v) {
        return MapEntry(k, v.map((k2, v2) {
          return MapEntry(
              k2.toIso8601String(), v2.map((k3, v3) => MapEntry(k3, v3)));
        }));
      }),
    };
  }

  factory Maid.fromMap(Map<String, dynamic> map) {
    return Maid(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      genre: map['genre'],
      email: map['email'],
      phone: map['phone'],
      ville: map['ville'],
      adresse: map['adresse'],
      registerDate: DateTime.parse(map['registerDate']),
      description: map['description'],
      photo: map['photo'],
      tags: map['tags']?.cast<String>(),
      events: (map['events'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e))
          .toList(),
      prixMin: map['prixMin'],
      prixMax: map['prixMax'],
      rating: map['rating'],
      nbrRating: map['nbrRating'],
      certified: map['certified'],
      coments: (map['comments'] as Map<String, dynamic>?)?.map((k, v) {
        return MapEntry(k, v?.map((k2, v2) {
          return MapEntry(DateTime.parse(k2), v2?.map((k3, v3) {
            return MapEntry(k3, v3);
          }));
        }));
      }),
    );
  }
}
