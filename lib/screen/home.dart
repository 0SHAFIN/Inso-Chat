import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inso_chat/component/assets/colors.dart';
import 'package:inso_chat/component/routs/routename.dart';
import 'package:inso_chat/screen/chatSscreen.dart';
import 'package:inso_chat/services/utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name;
  String? email;

  void getInfo() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    var ref = FirebaseFirestore.instance.collection("Users");
    await ref.doc(userId).get().then((value) {
      setState(() {
        name = value.data()!["Name"];
        email = value.data()!["email"];
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
    var height = MediaQuery.of(context).size.height * .1;
    var width = MediaQuery.of(context).size.width * .1;
    return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(color: Clr.primaryButton),
                  child: ListTile(
                    leading: Container(
                      // color: Colors.red,
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      "${name ?? 'N/A'}",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    subtitle: Text(
                      "${email ?? 'N/A'}",
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  )),
              SizedBox(
                height: height * .2,
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.profileScreen);
                },
                leading: Icon(Icons.person),
                title: Text("Profile"),
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
              ),
              ListTile(
                onTap: () {
                  var auth = FirebaseAuth.instance;
                  auth.signOut().then((value) {
                    Navigator.pushNamed(context, RouteName.loginScreen);
                  }).onError((error, stackTrace) {
                    Utils.showMessage(error.toString());
                  });
                },
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.grey)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * .12,
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index];
                            if (FirebaseAuth.instance.currentUser!.uid !=
                                data.id) {
                              return ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                                reciverId: data.id,
                                                reciverName: data["Name"],
                                                reciveremail: data["email"],
                                              )));
                                },
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Clr.primaryButton, width: 2),
                                      shape: BoxShape.circle),
                                  child: const Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Clr.primaryButton,
                                  ),
                                ),
                                title: Text(data["Name"]),
                                subtitle: Text(data["email"]),
                              );
                            } else {
                              return const SizedBox();
                            }
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        )));
  }
}
