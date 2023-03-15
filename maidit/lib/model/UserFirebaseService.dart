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

  Future<void> updateUser(String description, File photo, String genre,
      String ville, String adresse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDoc = _firestore.collection('users').doc(prefs.getString('uid'));

    // Upload photo to Firebase Storage
    if (photo.path.length > 10) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('users/profilPics/${userDoc.id}');
      final uploadTask = storageRef.putFile(photo);
      final snapshot = await uploadTask.whenComplete(() => null);
      final photoUrl = await snapshot.ref.getDownloadURL();

      // Update user document with new photo URL
      await userDoc.update({'photo': photoUrl});
    }

    // Update description and phone fields
    await userDoc.update({
      'description': description,
      'genre': genre,
      'ville': ville,
      'adresse': adresse,
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

  // Function to delete an existing user from Firebase
  Future<void> deleteUser(String userId) async {
    await _firestore.collection('users').doc(userId).delete();
  }

  // Function to get an existing user from Firebase
  Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection('users').doc(prefs.getString('uid')).get();
    if (!snapshot.exists) {
      return null;
    }
    return User.fromMap(snapshot.data()!);
  }
}
