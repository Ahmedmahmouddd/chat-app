import 'package:flutter/material.dart';

class AuthScreenTitleAndDescribtion extends StatelessWidget {
  const AuthScreenTitleAndDescribtion({
    super.key,
    required this.title,
    required this.desribtion,
  });
  final String title;
  final String desribtion;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(
                color: Colors.grey[900],
                fontWeight: FontWeight.w800,
                fontSize: 22),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            desribtion,
            style: TextStyle(
                fontSize: 17,
                color: Colors.grey[500],
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
