// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/Chat/screens/chat_screen.dart';
import 'package:chat_app/auth/widgets/custom_snack_bar.dart';
import 'package:chat_app/auth/widgets/custom_text_button.dart';
import 'package:chat_app/profile_picture/screens/adding_profile_pic_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.loginFormKey,
    required this.email,
    required this.password,
  });

  final GlobalKey<FormState> loginFormKey;
  final TextEditingController email;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      text: "Login",
      onPressed: () async {
        if (loginFormKey.currentState!.validate()) {
          try {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email.text, password: password.text);

            if (!FirebaseAuth.instance.currentUser!.emailVerified) {
              await FirebaseAuth.instance.currentUser!.sendEmailVerification();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.grey[100],
                  surfaceTintColor: Colors.white,
                  title: const Text('Verify Email'),
                  content: const Text(
                      'A verification email has been sent. Please verify your email and then press Ok.'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.currentUser!.reload(); // Reload user data
                        if (FirebaseAuth.instance.currentUser!.emailVerified) {
                          Navigator.of(context).pop();
                          password.clear();
                          email.clear();
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
                        style: TextStyle(color: Colors.blue[600]),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatScreen(),
                ),
                (route) => false,
              );
            }
          } on FirebaseAuthException catch (e) {
            if (e.code == 'invalid-credential') {
              showCustomSnackBar(context, "Wrong email or password provided.");
            }
          }
        }
      },
    );
  }
}
