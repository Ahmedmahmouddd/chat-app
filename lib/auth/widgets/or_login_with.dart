import 'package:flutter/material.dart';

class OrLoginWith extends StatelessWidget {
  const OrLoginWith({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Divider(
          thickness: 3,
          indent: 10,
          endIndent: 10,
          color: Colors.grey[300],
          height: 1,
        )),
        Text(
          "Or login with",
          style: TextStyle(fontSize: 17, color: Colors.grey[500], fontWeight: FontWeight.w700),
        ),
        Expanded(
            child: Divider(
          thickness: 3,
          indent: 10,
          endIndent: 10,
          color: Colors.grey[300],
          height: 1,
        )),
      ],
    );
  }
}
