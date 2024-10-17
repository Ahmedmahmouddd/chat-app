// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/Chat/screens/chat_screen.dart';
import 'package:chat_app/auth/methods/google_sign_method.dart';
import 'package:chat_app/auth/widgets/app_cicular_logo.dart';
import 'package:chat_app/auth/widgets/auth_screen_title.dart';
import 'package:chat_app/auth/widgets/custom_snack_bar.dart';
import 'package:chat_app/auth/widgets/custom_text_button.dart';
import 'package:chat_app/auth/widgets/dont_have_an_account.dart';
import 'package:chat_app/auth/widgets/or_login_with.dart';
import 'package:chat_app/auth/widgets/reset_password.dart';
import 'package:chat_app/auth/widgets/text_field_with_title.dart';
import 'package:chat_app/auth/widgets/validate_user_alert.dart';
import 'package:chat_app/cubits/google_signin_cubit/google_signin_cubit.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/profile_picture/screens/adding_profile_pic_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class LogIn extends StatelessWidget {
  LogIn({super.key});
  GlobalKey<FormState> loginFormKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController resetPassword = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginValidate) {
          showDialog(
              context: context, builder: (context) => ValidateUserAlert(password: password, email: email));
          isLoading = false;
        } else if (state is LoginSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AddingProfilePicScreen(),
            ),
            (route) => false,
          );
          isLoading = false;
        } else if (state is LoginFailure) {
          showCustomSnackBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return BlocConsumer<GoogleSignInCubit, GoogleSignInState>(
          listener: (context, state) {
            if (state is GoogleSignInLoading) {
              isLoading = true;
            } else if (state is GoogleSignInCancelled) {
              isLoading = false;
            } else if (state is GoogleSignInSuccessExistingUser) {
              isLoading = false;
              // User is returning, go directly to the chat page
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatScreen(), // Navigate to chat page
                ),
                (route) => false,
              );
            } else if (state is GoogleSignInSuccessNewUser) {
              isLoading = false;
              // Navigate to the profile picture screen for new users
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddingProfilePicScreen(), // Navigate to image upload page
                ),
                (route) => false,
              );
            } else if (state is GoogleSignInFailure) {
              showCustomSnackBar(context, state.errMessage);
              isLoading = false;
            }
          },
          builder: (context, state) {
            return ModalProgressHUD(
              progressIndicator: CircularProgressIndicator(color: Colors.blue[600]),
              inAsyncCall: isLoading,
              child: Scaffold(
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
                              CustomTextButton(
                                  text: "Login",
                                  onPressed: () async {
                                    if (loginFormKey.currentState!.validate()) {
                                      BlocProvider.of<LoginCubit>(context).login(email.text, password.text);
                                    }
                                  }),
                              const SizedBox(height: 12),
                              const OrLoginWith(),
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () async {
                                  BlocProvider.of<GoogleSignInCubit>(context).signInWithGoogle(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[50], borderRadius: BorderRadius.circular(50)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Image.asset(
                                      "assets/4.png",
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const DontHaveAnAccount(),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
