// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/Chat/screens/chat_screen.dart';
import 'package:chat_app/profile_picture/screens/adding_profile_pic_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> signInWithGoogle(BuildContext context) async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser == null) {
    return; // User canceled the sign-in
  }

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

  // Check if the user is new
  if (userCredential.additionalUserInfo!.isNewUser) {
    // Store user details in Firestore
    await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).set({
      'name': googleUser.displayName, // Get name from Google
      'email': userCredential.user!.email,
      // You can add other fields as necessary
    });

    // Navigate to the profile picture screen for new users
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AddingProfilePicScreen(), // Navigate to image upload page
      ),
      (route) => false,
    );
  } else {
    // User is returning, go directly to the chat page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatScreen(), // Navigate to chat page
      ),
      (route) => false,
    );
  }
}
