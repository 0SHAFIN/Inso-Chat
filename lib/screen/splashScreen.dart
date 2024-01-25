import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inso_chat/component/routs/routename.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, RouteName.loginScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 200,
                width: 200,
                child: Image.asset(
                  "assets/images/insoChat.png",
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              height: 400,
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(
                color: Color(0xffF26419),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
