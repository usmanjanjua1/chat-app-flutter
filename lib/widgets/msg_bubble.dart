import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MsgBubble extends StatelessWidget {
  final String msg;
  final Color clr;
  const MsgBubble({super.key, required this.msg, required this.clr});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: clr,
        ),
        child: Text(
          msg,
          style: const TextStyle(color: Colors.white, fontSize: 22),
        ),
      ),
    );
  }
}
