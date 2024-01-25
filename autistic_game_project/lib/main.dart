import 'package:flutter/material.dart';
import 'opening_screen.dart';
import 'mission_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => OpeningScreen());
          case '/mission':
            return MaterialPageRoute(builder: (_) => MissionScreen());
          default:
            return MaterialPageRoute(
                builder: (_) => Scaffold(body: Text('Unknown Route')));
        }
      },
    );
  }
}
