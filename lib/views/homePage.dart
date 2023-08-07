import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/views/Login.dart';
import 'package:firebase_chat/views/chatScreen.dart';
import 'package:firebase_chat/views/splash_screen.dart';
import 'package:firebase_chat/widgets/bottomNavBar.dart';
import 'package:flutter/material.dart';

import '../widgets/show_snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: buildBottomNavigationBar(),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                showCustomSnackBar(context, "Error");
                return Text("Error");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading...");
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  // Map<String, String> data = snapshot.data! as Map<String, String>;
                  if (auth.currentUser!.email != documentSnapshot['email']) {
                    return Card(
                      color: Colors.white70,
                      margin: const EdgeInsets.all(5),
                      child: ListTile(
                          title: Text(
                            documentSnapshot['email'],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          subtitle: const Text(
                            'Tap to send message',
                            style: TextStyle(color: Colors.black54),
                          ),
                          leading: const CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.person_2_rounded,
                              color: Colors.white,
                            ),
                            // backgroundImage: AssetImage('background.jpg'),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => chatScreen(
                                  recUserEmail: documentSnapshot['email'],

                                  // auth.currentUser!.email.toString(),
                                  recUserId: documentSnapshot['uid'],
                                  // auth.currentUser!.uid.toString(),
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return Container();
                  }
                },
                itemCount: snapshot.data!.docs.length,
              );
            },
          ),
        ),
        appBar:
            AppBar(centerTitle: true, title: const Text('Chat App'), actions: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Splash(),
                  ));
            },
            child: const CircleAvatar(
              child: Icon(
                Icons.logout_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
