import 'package:flutter/material.dart';
import 'package:inso_chat/component/routs/routename.dart';
import 'package:inso_chat/screen/home.dart';
import 'package:inso_chat/screen/login.dart';
import 'package:inso_chat/screen/signup.dart';
import 'package:inso_chat/screen/splashScreen.dart';

class Routs {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (context) => const Login());
      case RouteName.signupScreen:
        return MaterialPageRoute(builder: (context) => const SignUp());
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context) => const Home());

      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Text("Error"),
                ));
    }
  }
}
