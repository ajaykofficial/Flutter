// mission_three_screen.dart
import 'package:flutter/material.dart';

class MissionThreeScreen extends StatelessWidget {
  final List<String> categorizedWaste;

  MissionThreeScreen({required this.categorizedWaste});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mission Three: Final Mission'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Categorized Waste:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            for (String waste in categorizedWaste)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(waste),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic for the final mission and navigate accordingly
                Navigator.pushReplacementNamed(context, '/main_menu');
              },
              child: Text('Complete Mission'),
            ),
          ],
        ),
      ),
    );
  }
}
