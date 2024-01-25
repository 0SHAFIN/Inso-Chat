import 'package:flutter/material.dart';
import 'package:inso_chat/component/routs/routename.dart';
import 'package:inso_chat/component/routs/routs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.white70,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routs.generateRoute,
    );
  }
}
