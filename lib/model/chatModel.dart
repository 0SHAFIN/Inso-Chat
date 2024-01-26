import 'package:cloud_firestore/cloud_firestore.dart';

class chatModel {
  String reciverId;
  String senderId;
  String? senderName;
  String message;
  Timestamp time;

  chatModel({
    required this.reciverId,
    required this.senderId,
    this.senderName,
    required this.message,
    required this.time,
  });
  Map<String, dynamic> toMap() {
    return {
      "reciverId": reciverId,
      "senderId": senderId,
      "senderName": senderName,
      "message": message,
      "time": time,
    };
  }
}
