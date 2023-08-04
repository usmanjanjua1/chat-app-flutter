import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId = '';
  String senderEmail = '';
  String receiverId = '';
  String msg = '';
  Timestamp time;

  Message(
    this.senderId,
    this.senderEmail,
    this.receiverId,
    this.msg,
    this.time,
  );
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverID': receiverId,
      'message': msg,
      'timestamp': time,
    };
  }
}
