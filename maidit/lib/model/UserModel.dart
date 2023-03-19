// ignore_for_file: file_names

import 'dart:convert';

import 'UserHistory.dart';
import 'UserMessages.dart';

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
  List<UserHistory>? history = [];
  //this field will be sorted by datetime and by id in the chat
  List<UserMessages>? messages = [];

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
      'registerDate': registerDate.toIso8601String(),
      'description': description,
      'photo': photo,
      'tags': tags,
      'events':
          events?.map((key, value) => MapEntry(key.toIso8601String(), value)) ??
              {},
      'savedMaids': savedMaids ?? [],
      'history': history?.map((h) => h.toMap()).toList() ?? [],
      'messages': messages?.map((m) => m.toMap()).toList() ?? []
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
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
      tags: List<String>.from(map['tags']),
      events: (map['events'] as Map<String, dynamic>?)?.map(
            (key, value) =>
                MapEntry(DateTime.parse(key), value as List<String>?),
          ) ??
          {},
      savedMaids: List<String>.from(map['savedMaids']),
      history: (map['history'] as List<dynamic>?)
          ?.map((h) => UserHistory.fromMap(h as Map<String, dynamic>))
          .toList(),
      messages: [],
    );
  }

  String getUserAsStream() {
    final map = toMap();
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(map);
  }
}
