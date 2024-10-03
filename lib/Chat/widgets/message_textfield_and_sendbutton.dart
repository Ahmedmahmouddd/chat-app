import 'package:chat_app/auth/widgets/custom_text_field.dart';
import 'package:chat_app/Chat/methods/send_message_method.dart';
import 'package:flutter/material.dart';

class MessageTextFieldAndSendButton extends StatelessWidget {
  const MessageTextFieldAndSendButton({super.key, required this.messageController});
  
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 8, top: 8),
              child: CustomTextField(
                  myController: messageController,
                  hint: "Send a message",
                  obscureField: false,
                  initialObscureText: false),
            ),
          ),
          IconButton(
            onPressed: () async {
              await sendMessage(messageController.text);
              messageController.clear();
            },
            icon: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.grey[50]),
              child: Padding(
                padding: const EdgeInsets.only(right: 6, bottom: 8, left: 12, top: 8),
                child: Icon(
                  Icons.send_rounded,
                  color: Colors.blue[600],
                  size: 34,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
