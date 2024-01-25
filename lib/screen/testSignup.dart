import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inso_chat/component/inputField.dart';
import 'package:inso_chat/component/roundnutton.dart';
import 'package:inso_chat/component/routs/routename.dart';
import 'package:inso_chat/screen/login.dart';

class TesstSignup extends StatefulWidget {
  const TesstSignup({super.key});

  @override
  State<TesstSignup> createState() => _TesstSignupState();
}

class _TesstSignupState extends State<TesstSignup> {
  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var password = TextEditingController();
    var username = TextEditingController();
    void signup() async {
      var auth = FirebaseAuth.instance;
      var ref = FirebaseFirestore.instance.collection("users");
      await auth
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
        ref.doc(value.user!.uid).set({
          "email": email.text,
          "password": password.text,
          "username": username.text,
        }).then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => Login()));
        });
      });
    }

    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        children: [
          inputField(controller: username, hint: "Name", validator: (_) {}),
          SizedBox(
            height: 20,
          ),
          inputField(controller: email, hint: "email", validator: (_) {}),
          SizedBox(
            height: 20,
          ),
          inputField(controller: password, hint: "password", validator: (_) {}),
          SizedBox(
            height: 20,
          ),
          roundButton(
              hint: "SignUp",
              onTap: () {
                signup();
              }),
          Row(
            children: [
              Text("Already have an account?"),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.loginScreen);
                  },
                  child: Text("Signin"))
            ],
          )
        ],
      ),
    )));
  }
}
