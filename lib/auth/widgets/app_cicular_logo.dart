import 'package:flutter/material.dart';

class AppCircularLogo extends StatelessWidget {
  const AppCircularLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(150),
        color: Colors.grey[100],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Icon(
          Icons.chat_outlined,
          color: Colors.blue[600],
          size: 60,
        ),
      ),
    );
  }
}
