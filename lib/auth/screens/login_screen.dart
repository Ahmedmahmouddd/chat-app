// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/auth/widgets/app_cicular_logo.dart';
import 'package:chat_app/auth/widgets/auth_screen_title.dart';
import 'package:chat_app/auth/widgets/dont_have_an_account.dart';
import 'package:chat_app/auth/widgets/login_button.dart';
import 'package:chat_app/auth/widgets/or_login_with.dart';
import 'package:chat_app/auth/widgets/reset_password.dart';
import 'package:chat_app/auth/widgets/signin_with_google.dart';
import 'package:chat_app/auth/widgets/text_field_with_title.dart';

import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController resetPassword = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    resetPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Form(
            key: loginFormKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 40),
                    const AppCircularLogo(),
                    const SizedBox(height: 30),
                    const AuthScreenTitleAndDescribtion(
                      title: 'Login',
                      desribtion: "Login to continue using the app",
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 4),
                    ResetPassword(resetPassword: resetPassword),
                    const SizedBox(height: 12),
                    LoginButton(loginFormKey: loginFormKey, email: email, password: password),
                    const SizedBox(height: 12),
                    const OrLoginWith(),
                    const SizedBox(height: 12),
                    const SignInWithGoogle(),
                    const SizedBox(height: 16),
                    const DontHaveAnAccount(),
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
