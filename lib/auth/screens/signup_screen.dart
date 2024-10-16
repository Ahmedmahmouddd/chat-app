// ignore_for_file: use_build_context_synchronously
import 'package:chat_app/auth/widgets/app_cicular_logo.dart';
import 'package:chat_app/auth/widgets/auth_screen_title.dart';
import 'package:chat_app/auth/widgets/custom_snack_bar.dart';
import 'package:chat_app/auth/widgets/text_field_with_title.dart';
import 'package:chat_app/auth/widgets/custom_text_button.dart';
import 'package:chat_app/auth/widgets/validate_user_alert.dart';
import 'package:chat_app/cubits/signup_cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  SignUp({super.key});
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoading) {
          isLoading = true;
        } else if (state is SignUpFailure) {
          isLoading = false;
          showCustomSnackBar(context, state.errMessage);
        } else if (state is SignUpValidate) {
          showDialog(
            context: context,
            builder: (context) =>
                ValidateUserAlert(confirmPassword: confirmPassword, email: email, password: password),
          );
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
                                    BlocProvider.of<SignUpCubit>(context)
                                        .signUp(email.text, password.text, userName.text);
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
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[800], fontWeight: FontWeight.w700),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.blue[600], fontWeight: FontWeight.w700),
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
          ),
        );
      },
    );
  }
}
