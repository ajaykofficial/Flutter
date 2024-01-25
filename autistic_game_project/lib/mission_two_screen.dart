// mission_two_screen.dart
import 'package:flutter/material.dart';

class MissionTwoScreen extends StatelessWidget {
  final List<String> detectedWaste;

  MissionTwoScreen({required this.detectedWaste});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mission Two: Waste Categorization'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Detected Waste:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            for (String waste in detectedWaste)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(waste),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic for waste categorization and navigate to the next screen
                Navigator.pushReplacementNamed(context, '/mission');
              },
              child: Text('Next Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
