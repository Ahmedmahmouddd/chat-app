import 'package:chat_app/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWithTitle extends StatelessWidget {
  const CustomTextFieldWithTitle({
    super.key,
    required this.hint,
    required this.myController,
    required this.obscureField,
    required this.obscureText,
  });

  final String hint;
  final TextEditingController myController;
  final bool obscureField;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            hint,
            style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.w800, fontSize: 18),
          ),
        ),
        const SizedBox(height: 4),
        CustomTextField(
          myController: myController,
          hint: hint,
          obscureField: obscureField,
           initialObscureText: obscureText,
        ),
      ],
    );
  }
}
