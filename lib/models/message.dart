import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderId;
  final String senderEmail;
  final String recvID;
  final String msg;
  final Timestamp timeStamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.recvID,
    required this.msg,
    required this.timeStamp
});

  // Convert to a Map
  Map<String, dynamic> toMap(){
    return {
      'senderID': senderId,
      'senderEmail': senderEmail,
      'receiverID': recvID,
      'message': msg,
      'timestamp': timeStamp,
    };
  }
}