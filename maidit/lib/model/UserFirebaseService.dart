// ignore_for_file: file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/UserModel.dart';

class UserFirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // Function to create a new user in Firebase
  Future<String> createUser(User user, String email, String password) async {
    auth.UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    //add the user to FireBase
    await _firestore.collection('users').doc(cred.user!.uid).set(user.toMap());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', cred.user!.uid);
    return cred.user!.uid;
  }

  Future<void> updateUser(String description, File photo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDoc = _firestore.collection('users').doc(prefs.getString('uid'));

    // Upload photo to Firebase Storage
    if (photo.path.length > 10) {
      final storageRef =
          FirebaseStorage.instance.ref().child('users/${userDoc.id}/profilPic');
      final uploadTask = storageRef.putFile(photo);
      final snapshot = await uploadTask.whenComplete(() => null);
      final photoUrl = await snapshot.ref.getDownloadURL();

      // Update user document with new photo URL
      await userDoc.update({'photo': photoUrl});
    }

    // Update description and phone fields
    await userDoc.update({
      'id': prefs.getString('uid'),
      'description': description,
    });
  }

  Future<void> updateUserAddTags(List<String> tags) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDoc = _firestore.collection('users').doc(prefs.getString('uid'));
    // Update description and phone fields
    await userDoc.update({
      'tags': tags,
    });
  }

  Future<void> updateUserAddFavorite(String maidId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDoc = _firestore.collection('users').doc(prefs.getString('uid'));
    // Update description and phone fields
    await userDoc.update({
      'savedMaids': FieldValue.arrayUnion([maidId]),
    });
  }

  Future<void> updateUserRemoveFavorite(String maidId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDoc = _firestore.collection('users').doc(prefs.getString('uid'));
    DocumentSnapshot<Map<String, dynamic>> snapshot = await userDoc.get();
    List<String> savedMaids =
        List<String>.from(snapshot.data()?['savedMaids'] ?? []);
    if (savedMaids.contains(maidId)) {
      // Update savedMaids field by removing the maidId
      await userDoc.update({
        'savedMaids': FieldValue.arrayRemove([maidId]),
      });
    } else {}
  }

  Future<bool> isMaidFavorite(String maidId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDoc = _firestore.collection('users').doc(prefs.getString('uid'));
    DocumentSnapshot<Map<String, dynamic>> snapshot = await userDoc.get();
    List<String> savedMaids =
        List<String>.from(snapshot.data()?['savedMaids'] ?? []);
    if (savedMaids.contains(maidId)) {
      return true;
    } else {
      return false;
    }
  }

  // Function to get an existing user from Firebase
  // ignore: body_might_complete_normally_nullable
  Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').doc(prefs.getString('uid')).get();
    if (!snapshot.exists) {
      return null;
    }
    if (snapshot.exists) {
      return User.fromMap(snapshot.data()!);
    }
  }

  // Function to delete an existing user from Firebase
  Future<void> deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _firestore.collection('users').doc(prefs.getString('uid')).delete();
  }
}
