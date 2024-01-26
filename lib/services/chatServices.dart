import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inso_chat/model/chatModel.dart';

class chatServices {
  var ref = FirebaseFirestore.instance.collection("Chat_room");

  void sendMessage(String reciverId, String message) async {
    var senderId = FirebaseAuth.instance.currentUser!.uid;
    var senderName = await FirebaseFirestore.instance
        .collection("Users")
        .doc(senderId)
        .get()
        .then((value) => value.data()!["Name"]);
    var time = Timestamp.now();
    var chat = chatModel(
        reciverId: reciverId,
        senderId: senderId,
        senderName: senderName,
        message: message,
        time: time);

    List<String> ids = [reciverId, senderId];
    ids.sort();
    var chatId = ids.join("_");
    await ref.doc(chatId).collection("messages").add(chat.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userId, String oderUserId) {
    List<String> ids = [userId, oderUserId];
    ids.sort();
    var chatId = ids.join("_");
    return ref.doc(chatId).collection("messages").orderBy("time").snapshots();
  }
}
