import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var name;
  var email;
  var phone;
  var gender;
  var dob;
  void getInfo() async {
    var userid = FirebaseAuth.instance.currentUser!.uid;
    var ref = FirebaseFirestore.instance.collection("Users");
    await ref.doc(userid).get().then((value) {
      setState(() {
        name = value.data()!["Name"];
        email = value.data()!["email"];
        phone = value.data()!["phone"];
        gender = value.data()!["gender"];
        dob = value.data()!["dob"];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Column(children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 45,
                  child: Icon(Icons.person, size: 42),
                )
              ],
            ),
            Divider(
              height: 50,
              thickness: 2,
            ),
            Column(
              children: [
                Card(
                  child: ListTile(
                      title: Row(
                    children: [
                      Text("Name :"),
                      Spacer(),
                      Text("${name ?? 'N/A'}")
                    ],
                  )),
                ),
                Card(
                  child: ListTile(
                      title: Row(
                    children: [
                      Text("Email :"),
                      Spacer(),
                      Text("${email ?? 'N/A'}")
                    ],
                  )),
                ),
                Card(
                  child: ListTile(
                      title: Row(
                    children: [
                      Text("Phone :"),
                      Spacer(),
                      Text("${phone ?? 'N/A'}")
                    ],
                  )),
                ),
                Card(
                  child: ListTile(
                      title: Row(
                    children: [
                      Text("Gender :"),
                      Spacer(),
                      Text("${gender ?? 'N/A'}")
                    ],
                  )),
                ),
                Card(
                  child: ListTile(
                      title: Row(
                    children: [
                      Text("Date of birth :"),
                      Spacer(),
                      Text("${dob ?? 'N/A'}")
                    ],
                  )),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
