import 'package:flutter/material.dart';
import 'package:inso_chat/component/assets/colors.dart';
import 'package:inso_chat/component/routs/routename.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * .1;
    var width = MediaQuery.of(context).size.width * .1;
    return Scaffold(
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
                    title: const Text(
                      "Tafsirul Islam Shafin",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    subtitle: const Text(
                      "Shafin@gmail.com",
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  )),
              SizedBox(
                height: height * .2,
              ),
              const ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.loginScreen);
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
                  const CircleAvatar(
                    radius: 25,
                    child: Icon(Icons.person),
                  ),
                  SizedBox(
                    width: width * .3,
                  ),
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
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return const ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          child: Icon(Icons.person),
                        ),
                        title: Text("Tafsirul Islam Shafin"),
                        subtitle: Text("Hello"),
                        trailing: Text("12:00"),
                      );
                    }),
              ),
            ],
          ),
        )));
  }
}
