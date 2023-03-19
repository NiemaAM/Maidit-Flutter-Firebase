// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class UserMessages {
  final String message;
  final DateTime dateTime;
  final String userId;
  final String recipientId;
  final List<String>? imageUrls;
  final String? audioUrl;
  final List<String>? videoUrl;

  UserMessages({
    required this.message,
    required this.dateTime,
    required this.userId,
    required this.recipientId,
    this.imageUrls,
    this.audioUrl,
    this.videoUrl,
  });

  factory UserMessages.fromMap(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return UserMessages(
      message: data['message'],
      dateTime: DateTime.parse(data['dateTime']),
      userId: data['userId'],
      recipientId: data['recipientId'],
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      audioUrl: data['audioUrl'],
      videoUrl: List<String>.from(data['videoUrl'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'dateTime': dateTime.toIso8601String(),
      'userId': userId,
      'recipientId': recipientId,
      'imageUrls': imageUrls,
      'audioUrl': audioUrl,
      'videoUrl': videoUrl,
    };
  }
}
