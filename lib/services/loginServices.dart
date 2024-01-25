import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inso_chat/component/routs/routename.dart';
import 'package:inso_chat/model/userModel.dart';
import 'package:inso_chat/services/utils.dart';

class login with ChangeNotifier {
  bool loading = false;
  var auth = FirebaseAuth.instance;
  var ref = FirebaseFirestore.instance.collection("Users");
  void logins(BuildContext context, String email, String password) async {
    try {
      loading = true;
      notifyListeners();
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        loading = false;
        notifyListeners();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Login Success")));

        Navigator.pushNamed(context, RouteName.homeScreen);
      }).onError((error, stackTrace) {
        loading = false;
        notifyListeners();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    } catch (e) {
      Utils.showMessage(e.toString());
    }
  }

  void signUp(BuildContext context, String fname, String lname, String phone,
      String gender, String dob, String email, String password) async {
    try {
      UsersModel user = UsersModel(
          fname: fname,
          lname: lname,
          phone: phone,
          gender: gender,
          dob: dob,
          email: email,
          password: password);
      loading = true;
      notifyListeners();
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        ref.doc(value.user!.uid).set(user.toMap()).then((value) {
          loading = false;
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login and Signup Success")));
          Navigator.pushNamed(context, RouteName.loginScreen);
        });
      }).onError((error, stackTrace) {
        loading = false;
        notifyListeners();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
