// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

Future<void> sendMessage(String message) async {
  CollectionReference messages = FirebaseFirestore.instance.collection('Chat');

  String userId = FirebaseAuth.instance.currentUser!.uid;

  DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
  String senderName = userDoc['name'];
  String imageUrl = userDoc['profilePictureUrl'] ?? 'https://img.freepik.com/premium-vector/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-vector-illustration_561158-3383.jpg?w=360';


  return messages
      .add({
        'messageContent': message,
        "senderId": FirebaseAuth.instance.currentUser!.uid, // Use UID for better identification
        "senderName": senderName,
        "id": FirebaseAuth.instance.currentUser!.email!,
        'time': printCurrentTime(),
        'timestamp': FieldValue.serverTimestamp(),
        'image': imageUrl
      })
      .then((value) => print("Message sent"))
      .catchError((error) => print("Failed to sent message: $error"));
}

String printCurrentTime() {
  String formattedTime = DateFormat('h:mm a').format(DateTime.now());
  return formattedTime; // Output will be something like "2:30 PM"
}
