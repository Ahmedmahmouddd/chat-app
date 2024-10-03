import 'package:chat_app/Chat/screens/chat_screen.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/auth/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser == null || !FirebaseAuth.instance.currentUser!.emailVerified)
          ? const LogIn()
          : const ChatScreen(),
    );
  }
}
