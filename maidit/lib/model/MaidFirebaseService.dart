// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/MaidModel.dart';

class MaidFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to create a new Maid in Firebase
  Future<void> createMaid(Maid maid) async {
    await _firestore.collection('maids').doc(maid.id).set(maid.toMap());
  }

  // Function to update an existing Maid in Firebase
  Future<void> updateMaid(Maid maid) async {
    await _firestore.collection('maids').doc(maid.id).update(maid.toMap());
  }

  // Function to delete an existing Maid from Firebase
  Future<void> deleteMaid(String maidId) async {
    await _firestore.collection('maids').doc(maidId).delete();
  }

  Future<Maid?> getMaid(String maidId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('maids').doc(maidId).get();
    if (!snapshot.exists) {
      return null;
    }
    return Maid.fromMap(snapshot.data()!);
  }
}
