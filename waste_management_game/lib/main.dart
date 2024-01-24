import 'package:flutter/material.dart';
import 'welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste Management Game',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: WelcomeScreen(),
    );
  }
}
