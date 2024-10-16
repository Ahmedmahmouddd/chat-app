// ignore_for_file: use_build_context_synchronously, avoid_print
import 'package:chat_app/Chat/widgets/message_textfield_and_sendbutton.dart';
import 'package:chat_app/auth/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/Chat/widgets/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();
  final Stream<QuerySnapshot> messagesStream =
      FirebaseFirestore.instance.collection('Chat').orderBy('timestamp', descending: true).snapshots();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Chat",
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.grey[600],
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.grey[50],
                      surfaceTintColor: Colors.white,
                      title: const Text('Confirm email'),
                      content: const Text("Are you sure you want to logout ?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'No',
                            style: TextStyle(color: Colors.blue[600]),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            var user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              bool isGoogleUser =
                                  user.providerData.any((provider) => provider.providerId == 'google.com');

                              if (isGoogleUser) {
                                await GoogleSignIn().disconnect();
                              }

                              await FirebaseAuth.instance.signOut();
                            }
                            Navigator.pushAndRemoveUntil(
                                context, MaterialPageRoute(builder: (context) => LogIn()), (route) => false);
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.red[600]),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.grey[50],
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder(
              stream: messagesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (scrollController.hasClients) {
                    scrollController.jumpTo(0);
                  }
                });

                return ListView(
                  reverse: true,
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: data['id'] == FirebaseAuth.instance.currentUser!.email!
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        data['id'] == FirebaseAuth.instance.currentUser!.email!
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.only(left: 4.0, bottom: 5),
                                child: Container(
                                  height: MediaQuery.of(context).size.width * 0.12,
                                  width: MediaQuery.of(context).size.width * 0.12,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: Image(
                                      image: data['image'].startsWith('http')
                                          ? NetworkImage(data['image'])
                                          : const AssetImage("assets/no_profile_img.png") as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                        ChatBubble(
                          message: data['messageContent'],
                          time: data['time'],
                          isMe: data['id'] == FirebaseAuth.instance.currentUser!.email! ? true : false,
                          sender: data['senderName'] ?? data['id'],
                        ),
                      ],
                    );
                  }).toList(),
                );
              },
            )),
            MessageTextFieldAndSendButton(messageController: messageController),
          ],
        ));
  }
}
