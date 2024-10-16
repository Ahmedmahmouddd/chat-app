// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/auth/widgets/custom_snack_bar.dart';
import 'package:chat_app/profile_picture/screens/adding_profile_pic_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ValidateUserAlert extends StatelessWidget {
  const ValidateUserAlert({
    super.key,
    required this.email,
    required this.password,
    this.confirmPassword, // Optional parameter
  });

  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController? confirmPassword; // Made optional

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[100],
      surfaceTintColor: Colors.white,
      title: const Text('Verify Email'),
      content: const Text(
          'A verification email has been sent. Please verify your email and then press Ok.'),
      actions: [
        TextButton(
          onPressed: () async {
            await FirebaseAuth.instance.currentUser!
                .reload(); // Reload user data
            if (FirebaseAuth.instance.currentUser!.emailVerified) {
              Navigator.of(context).pop();
              // Clear the required fields
              password.clear();
              email.clear();
              // Clear confirmPassword if it exists
              confirmPassword?.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddingProfilePicScreen(),
                ),
                (route) => false,
              );
            } else {
              showCustomSnackBar(context, "Still not verified");
            }
          },
          child: Text(
            'OK',
            style: TextStyle(
                color: Colors.blue[600], fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
