import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/models/message.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //msg sending func is here
  Future<void> sendMsg(String recUserId, String msg) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

//
    Message newmsg = Message(
      currentUserId,
      currentUserEmail,
      recUserId,
      msg,
      timestamp,
    );

//creating a chat room id hre
    List<String> chatId = [currentUserId, recUserId];
    chatId.sort();
    String chatRoomId = chatId.join('_');

    //sending  msg
    await fireStore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('msgs')
        .add(newmsg.toMap());
  }

//msg receive
  Stream<QuerySnapshot> getMsgs(String userId, String otherUserID) {
    List<String> ids = [userId, otherUserID];
    ids.sort();
    String chatRoomId = ids.join('_');
    return fireStore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('msgs')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
