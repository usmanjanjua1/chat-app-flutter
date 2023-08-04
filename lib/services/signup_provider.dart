import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/main.dart';
import 'package:firebase_chat/models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpProvider with ChangeNotifier {
  Future<User?> signUp(String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      fireStore.collection('users').doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": userCredential.user!.email,
      });
      // fireStore.collection('users').doc(userCredential.user!.uid).set({
      //   "uid": userCredential.user!.uid,
      //   "email": userCredential.user!.email,
      // });

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
