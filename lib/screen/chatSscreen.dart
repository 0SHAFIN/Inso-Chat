import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inso_chat/model/chatModel.dart';
import 'package:inso_chat/services/chatServices.dart';

class ChatScreen extends StatefulWidget {
  var reciverId;
  var reciverName;
  var reciveremail;
  ChatScreen({super.key, this.reciverId, this.reciverName, this.reciveremail});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var chat = chatServices();
  var msg = TextEditingController();
  void sendMsg() async {
    chat.sendMessage(widget.reciverId, msg.text);
    msg.clear();
  }

  String? myName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        myName = value.data()!["Name"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.reciverName),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: buildMessageScreen()),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: msg,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.grey)),
                      hintText: "Type a message",
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    sendMsg();
                  },
                  icon: Icon(Icons.send),
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  Widget buildMessageScreen() {
    return StreamBuilder(
        stream: chat.getMessage(
            FirebaseAuth.instance.currentUser!.uid, widget.reciverId!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map<Widget>((e) {
              return buildMssgItem(e);
            }).toList(),
          );
        });
  }

  Widget buildMssgItem(DocumentSnapshot e) {
    Map<String, dynamic> data = e.data() as Map<String, dynamic>;
    bool isCurrentUser =
        data["senderId"] == FirebaseAuth.instance.currentUser!.uid.toString();

    var align = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: align,
        child: Card(
          color: isCurrentUser ? Colors.blue : Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isCurrentUser
                ? Text(
                    data["message"],
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  )
                : Text(data["message"]),
          ),
        ));
  }
}
