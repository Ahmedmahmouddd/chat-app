// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> saveUserDetails(String name) {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  // Use the UID as the document ID
  return users
      .doc(FirebaseAuth.instance.currentUser!.uid) // Reference the document with the UID
      .set({
        'name': name,
        'email': FirebaseAuth.instance.currentUser!.email!, // Store email
      })
      .then((value) => print("User details saved"))
      .catchError((error) => print("Failed to save user details: $error"));
}
