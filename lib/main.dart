import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inso_chat/component/routs/routename.dart';
import 'package:inso_chat/component/routs/routs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routs.generateRoute,
    );
  }
}
