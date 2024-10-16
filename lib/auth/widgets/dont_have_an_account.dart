import 'package:chat_app/auth/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class DontHaveAnAccount extends StatelessWidget {
  const DontHaveAnAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          r"Don't have an account yet? ",
          style:
              TextStyle(fontSize: 18, color: Colors.grey[800], fontWeight: FontWeight.w700),
        ),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
            return  SignUp();
          })),
          child: Text(
            "Sign up",
            style:
                TextStyle(fontSize: 18, color: Colors.blue[600], fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
