import 'package:firebase_chat/models/user.dart';
import 'package:firebase_chat/services/auth_provider.dart';
import 'package:firebase_chat/services/signup_provider.dart';
import 'package:firebase_chat/views/Login.dart';
import 'package:firebase_chat/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

MyUser? user_logged;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
    ChangeNotifierProvider<SignUpProvider>(create: (_) => SignUpProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our Chat ',
      home: Splash(),
    );
  }
}
