// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/auth/widgets/custom_snack_bar.dart';
import 'package:chat_app/auth/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({
    super.key,
    required this.resetPassword,
  });

  final TextEditingController resetPassword;
  final GlobalKey<FormState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.grey[50],
              surfaceTintColor: Colors.white,
              title: const Text('Confirm email'),
              content: CustomTextField(
                myController: resetPassword,
                hint: "Enter your email ",
                obscureField: false,
                initialObscureText: false,
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (globalKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: resetPassword.text.trim(),
                        );
                        resetPassword.clear();
                        Navigator.of(context).pop();
                        showCustomSnackBar(context,
                            "If this email has an account with us, An email will be sent to you to reset  password");
                      } on FirebaseAuthException catch (e) {
                        showCustomSnackBar(context, e.message ?? "This email address is badly formated.");
                      } catch (e) {
                        // Handle other errors here
                        showCustomSnackBar(context, '$e');
                      }
                    }
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(color: Colors.blue[600]),
                  ),
                ),
              ],
            ),
          );
        },
        child: Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Forgot Password?",
            style: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w700, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
