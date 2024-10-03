import 'package:chat_app/auth/methods/google_sign_method.dart';
import 'package:flutter/material.dart';

class SignInWithGoogle extends StatelessWidget {
  const SignInWithGoogle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await signInWithGoogle(context);
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(50)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            "assets/4.png",
          ),
        ),
      ),
    );
  }
}
