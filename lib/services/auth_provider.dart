// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/views/homePage.dart';
import 'package:firebase_chat/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<User?> signIn(
      String email, String password, BuildContext context) async {
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      fireStore.collection('users').doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": userCredential.user!.email,
      });

      user = userCredential.user;

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
      showCustomSnackBar(context, "Welcome $email");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showCustomSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showCustomSnackBar(context, 'Wrong password provided.');
      }
    }

    Future<void> signOut() async {
      await auth.signOut();
    }
  }
}
