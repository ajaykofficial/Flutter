import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        reverse: true,
        children: [
          // Full-screen image background
          Image.asset(
            'assets/images/map1.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 3,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
