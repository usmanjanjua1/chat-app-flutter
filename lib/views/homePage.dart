import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/views/chatScreen.dart';
import 'package:flutter/material.dart';

import '../widgets/show_snackbar.dart';
import 'msgScreen.dart';

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
                      color: Colors.white60,
                      margin: const EdgeInsets.all(5),
                      child: ListTile(
                          title: Text(documentSnapshot['email']),
                          subtitle: const Text(
                            'Tap to send message',
                            style: TextStyle(color: Colors.black54),
                          ),
                          trailing: const CircleAvatar(
                            child: Icon(Icons.person_2_rounded),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => chatScreen(
                                  recUserEmail:
                                      auth.currentUser!.email.toString(),
                                  recUserId: auth.currentUser!.uid.toString(),
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
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Chat App'),
          leading: const CircleAvatar(
            child: Icon(Icons.message_rounded),
          ),
        ),
      ),
    );
  }
}
