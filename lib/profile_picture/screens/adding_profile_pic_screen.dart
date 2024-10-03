import 'dart:io';

import 'package:chat_app/Chat/screens/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddingProfilePicScreen extends StatefulWidget {
  const AddingProfilePicScreen({super.key});

  @override
  State<AddingProfilePicScreen> createState() => _AddingProfilePicScreenState();
}

class _AddingProfilePicScreenState extends State<AddingProfilePicScreen> {
  File? selectedImage; // To store the image file
  String? downloadUrl; // To store the download URL if using Firebase
  bool isImageSelected = false;
  Future<void> uploadProfilePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return;
    } else {
      setState(() {
        selectedImage = File(pickedFile.path);
        isImageSelected = true;
      });
      String userId = FirebaseAuth.instance.currentUser!.uid;

      // Upload to Firebase Storage
      Reference storageRef = FirebaseStorage.instance.ref().child('profile_pictures/$userId.jpg');
      await storageRef.putFile(selectedImage!);

      // Get the download URL
      downloadUrl = await storageRef.getDownloadURL();

      // Save the URL in Firestore
      await FirebaseFirestore.instance.collection('Users').doc(userId).update({
        'profilePictureUrl': downloadUrl,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Icon(Icons.chat_outlined, color: Colors.blue[600], size: 60),
            const SizedBox(height: 30),
            Text(
              "Add A Picture to Have Better Interactions With Others",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.grey[600]),
            ),
            const SizedBox(height: 50),
            CircleAvatar(
              radius: 80,
              backgroundImage: selectedImage != null
                  ? FileImage(selectedImage!) // Display the selected image
                  : const AssetImage("assets/no_profile_img.png") as ImageProvider,
            ),
            const SizedBox(height: 20),
            const SizedBox(width: 10),
            CustomContainer(
              color: Colors.blue[600]!,
              onPressed: () {
                uploadProfilePicture();
              },
              text: 'Add a picture',
              width: 160,
            ),
            const Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomContainer(
                    color: !isImageSelected ? Colors.grey[500]! : Colors.blue[600]!,
                    onPressed: isImageSelected
                        ? () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const ChatScreen()),
                                (route) => false);
                          }
                        : () {},
                    text: 'Next',
                    width: 120,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key, required this.text, required this.onPressed, required this.width, required this.color});

  final VoidCallback onPressed;
  final String text;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(50)),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
