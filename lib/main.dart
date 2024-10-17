import 'package:chat_app/Chat/screens/chat_screen.dart';
import 'package:chat_app/cubits/google_signin_cubit/google_signin_cubit.dart';
import 'package:chat_app/cubits/login_cubit/login_cubit.dart';
import 'package:chat_app/cubits/signup_cubit/signup_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/auth/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => GoogleSignInCubit()),

      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: (FirebaseAuth.instance.currentUser == null || !FirebaseAuth.instance.currentUser!.emailVerified)
            ? LogIn()
            : const ChatScreen(),
      ),
    );
  }
}
