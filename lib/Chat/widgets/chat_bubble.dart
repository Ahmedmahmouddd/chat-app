import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isMe,
    required this.sender,
  });
  final String sender;
  final bool isMe;
  final String message;
  final String time;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7, // Max width
          minWidth: MediaQuery.of(context).size.width * 0.3,
        ),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue[600] : Colors.grey[600],
          borderRadius: isMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(0),
                  bottomLeft: Radius.circular(16),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(0),
                ),
        ),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            !isMe
                ? Text(sender, style: const TextStyle(color: Colors.white, fontSize: 16))
                : const SizedBox(width: 0),
            Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              time,
              style: const TextStyle(color: Color.fromARGB(220, 255, 255, 255), fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
