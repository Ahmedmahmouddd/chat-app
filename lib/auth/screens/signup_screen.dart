// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/auth/methods/save_user_details.dart';
import 'package:chat_app/auth/widgets/app_cicular_logo.dart';
import 'package:chat_app/auth/widgets/auth_screen_title.dart';
import 'package:chat_app/auth/widgets/custom_snack_bar.dart';
import 'package:chat_app/auth/widgets/text_field_with_title.dart';
import 'package:chat_app/auth/widgets/custom_text_button.dart';
import 'package:chat_app/profile_picture/screens/adding_profile_pic_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: signupFormKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 40),
                    const AppCircularLogo(),
                    const SizedBox(height: 30),
                    const AuthScreenTitleAndDescribtion(
                      title: 'Sign up',
                      desribtion: "Sign up to continue using the app",
                    ),
                    const SizedBox(height: 20),
                    CustomTextFieldWithTitle(
                      hint: "Username",
                      myController: userName,
                      obscureField: false,
                      obscureText: false,
                    ),
                    const SizedBox(height: 8),
                    CustomTextFieldWithTitle(
                      hint: "Email",
                      myController: email,
                      obscureField: false,
                      obscureText: false,
                    ),
                    const SizedBox(height: 8),
                    CustomTextFieldWithTitle(
                      hint: "Password",
                      myController: password,
                      obscureField: true,
                      obscureText: true,
                    ),
                    const SizedBox(height: 8),
                    CustomTextFieldWithTitle(
                      hint: "Confirm Password",
                      myController: confirmPassword,
                      obscureField: true,
                      obscureText: true,
                    ),
                    const SizedBox(height: 30),
                    CustomTextButton(
                        text: "Sign Up",
                        onPressed: () async {
                          if (signupFormKey.currentState!.validate()) {
                            if (password.text == confirmPassword.text) {
                              try {
                                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text,
                                );

                                saveUserDetails(userName.text);

                                await FirebaseAuth.instance.currentUser!.sendEmailVerification();
                                confirmPassword.clear();
                                email.clear();
                                password.clear();

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
                                          await FirebaseAuth.instance.currentUser!
                                              .reload(); // Reload user data
                                          if (FirebaseAuth.instance.currentUser!.emailVerified) {
                                            Navigator.of(context).pop();
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const AddingProfilePicScreen(),
                                              ),
                                              (route) => false,
                                            );
                                          } else {
                                            showCustomSnackBar(context, "STILL NOT VERIFIED");
                                          }
                                        },
                                        child: Text(
                                          'OK',
                                          style:
                                              TextStyle(color: Colors.blue[600], fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  showCustomSnackBar(context, "The password provided is too weak.");
                                } else if (e.code == 'email-already-in-use') {
                                  showCustomSnackBar(context,
                                      "An account already exists for that email. If it is yours, Login instead.");
                                } else if (e.code == 'invalid-email') {
                                  showCustomSnackBar(context, "The email provided is invalid.");
                                }
                              }
                            } else {
                              showCustomSnackBar(context, "Passwords are not matching.");
                            }
                          }
                        }),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account ",
                          style:
                              TextStyle(fontSize: 18, color: Colors.grey[800], fontWeight: FontWeight.w700),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            "Login",
                            style:
                                TextStyle(fontSize: 18, color: Colors.blue[600], fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
