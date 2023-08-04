import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/services/chati_provider.dart';
import 'package:flutter/material.dart';

class chatScreen extends StatefulWidget {
  final String recUserEmail;
  final String recUserId;

  const chatScreen({
    super.key,
    required this.recUserEmail,
    required this.recUserId,
  });

  @override
  State<chatScreen> createState() => _chatScreenState();
}

final TextEditingController msgController = TextEditingController();
final FirebaseAuth auth = FirebaseAuth.instance;
final ChatProvider mychatProvider = ChatProvider();

class _chatScreenState extends State<chatScreen> {
//func to send msg
  void sendMsg() async {
    if (msgController.text.isNotEmpty) {
      await mychatProvider.sendMsg(
          widget.recUserId, msgController.text.toString());

      msgController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recUserEmail),
        backgroundColor: Colors.black26,
      ),
      body: Column(
        children: [
          Expanded(child: chatBuilder()),
          msgInputField(),
        ],
      ),
    );
  }

  Widget chatBuilder() {
    print('chatbuilder');
    return StreamBuilder(
      stream: mychatProvider.getMsgs(widget.recUserId, auth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('circularprogress');
          return const CircularProgressIndicator(
            color: Colors.black,
          );
        }
        return ListView(
          children:
              snapshot.data!.docs.map((document) => msgTile(document)).toList(),
        );
      },
    );
  }

  Widget msgInputField() {
    print('msgInputField');
    return Row(
      children: [
        Expanded(
            child: TextField(
          controller: msgController,
          obscureText: false,
          decoration: InputDecoration(
              hintText: 'Enter Message',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              prefixIcon: InkWell(
                onTap: () => sendMsg(),
                child: const Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.black,
                ),
              )),
        ))
      ],
    );
  }

//msgTile
  Widget msgTile(DocumentSnapshot snapshot) {
    print('msgTile');
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    var myAlignment = data['senderId'] == auth.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: myAlignment,
      child: Column(
        children: [
          // Text(data['senderEmail']),
          Text(
            data['message'],
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

//builder
