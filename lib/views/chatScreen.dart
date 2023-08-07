import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/services/chati_provider.dart';
import 'package:firebase_chat/widgets/msg_bubble.dart';
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
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('background2.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              title: Text(widget.recUserEmail),
              actions: [
                IconButton(
                  icon: const Icon(Icons.local_phone),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.videocam),
                  onPressed: () {},
                ),
              ],
            ),
            Expanded(child: chatBuilder()),
            msgInputField(),
          ],
        ),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            style: TextStyle(color: Colors.white),
            controller: msgController,
            obscureText: false,
            decoration: InputDecoration(
              hintStyle: const TextStyle(color: Colors.white),
              hintText: 'Enter Message',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          )),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () => sendMsg(),
            child: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.black,
                )),
          ),
        ],
      ),
    );
  }

//msgTile
  Widget msgTile(DocumentSnapshot snapshot) {
    print('msgTile');
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    var myAlignment = data['senderId'] == auth.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft;
    Color clr =
        data['senderId'] == auth.currentUser!.uid ? Colors.grey : Colors.green;
    return Container(
      alignment: myAlignment,
      child: Column(
        crossAxisAlignment: (data['senderId'] == auth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: (data['senderId'] == auth.currentUser!.uid)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          // Text(data['senderEmail']),

          // data['message'],
          // style: TextStyle(color: Colors.black, fontSize: 18),
          MsgBubble(
            msg: data['message'].toString(),
            clr: clr,
          ),
        ],
      ),
    );
  }
}

//builder
