// ignore_for_file: file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/MaidModel.dart';

class MaidFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // Function to create a new user in Firebase
  Future<String?> createMaid(Maid maid, String email, String password) async {
    try {
      auth.UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //add the user to FireBase
      await _firestore
          .collection('maids')
          .doc(cred.user!.uid)
          .set(maid.toMap());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('uid', cred.user!.uid);
      return "Compte crée avec succés";
    } on auth.FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
      return "Cette adresse email existe déja!";
    }
  }

  Future<void> updateMaid(String description, File photo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDoc = _firestore.collection('maids').doc(prefs.getString('uid'));

    // Upload photo to Firebase Storage
    if (photo.path.length > 10) {
      final storageRef =
          FirebaseStorage.instance.ref().child('maids/${userDoc.id}/profilPic');
      final uploadTask = storageRef.putFile(photo);
      final snapshot = await uploadTask.whenComplete(() => null);
      final photoUrl = await snapshot.ref.getDownloadURL();

      // Update user document with new photo URL
      await userDoc.update({'photo': photoUrl});
    }

    // Update description and phone fields
    await userDoc.update({
      'id': userDoc.id,
      'description': description,
    });
  }

  Future<void> updateMaidAddTags(List<String> tags) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDoc = _firestore.collection('maids').doc(prefs.getString('uid'));
    // Update description and phone fields
    await userDoc.update({
      'tags': tags,
    });
  }

  // Function to get an existing user from Firebase
  // ignore: body_might_complete_normally_nullable
  Future<Maid?> getMaid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('maids').doc(prefs.getString('uid')).get();
    if (!snapshot.exists) {
      return null;
    }
    if (snapshot.exists) {
      return Maid.fromMap(snapshot.data()!);
    }
  }

  // Function to delete an existing user from Firebase
  Future<void> deleteMaid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _firestore.collection('maids').doc(prefs.getString('uid')).delete();
  }

  Future<List<Maid>> getAllMaids() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('maids').get();
    return snapshot.docs.map((doc) => Maid.fromMap(doc.data())).toList();
  }

  Future<List<Maid>> getSomeMaids() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('maids')
        .orderBy('rating', descending: true)
        .limit(30)
        .get();
    return snapshot.docs.map((doc) => Maid.fromMap(doc.data())).toList();
  }

  Future<List<Maid>> getMaidsByIds(List<String> ids) async {
    List<Maid> maids = [];
    if (ids.isNotEmpty) {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('maids')
          .where(FieldPath.documentId, whereIn: ids)
          .get();
      for (var doc in snapshot.docs) {
        Maid maid = Maid.fromMap(doc.data());
        maids.add(maid);
      }
    } else {}

    return maids;
  }

  Future<List<Maid>> getMaidsByTag(List<String> tags) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .collection('maids')
        .where('tags', arrayContainsAny: tags)
        .get();
    List<Maid> maids = [];
    for (var documentSnapshot in querySnapshot.docs) {
      Maid maid = Maid.fromMap(documentSnapshot.data());
      maids.add(maid);
    }
    return maids;
  }
}
