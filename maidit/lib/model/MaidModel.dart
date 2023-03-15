// ignore_for_file: file_names
class Maid {
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
  List<DateTime>? events = [];
  double prixMin = 0.0;
  double prixMax = 0.0;
  double rating = 0.0;
  int nbrRating = 0;

  Maid({
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
    required this.prixMin,
    required this.prixMax,
    required this.rating,
    required this.nbrRating,
  });
}
