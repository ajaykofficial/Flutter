import 'package:flutter/material.dart';

class WasteCategorizingScreen extends StatelessWidget {
  final List<String> categorizedWaste;

  WasteCategorizingScreen({required this.categorizedWaste});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waste Categorizing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categorized Wastes:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: categorizedWaste.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(categorizedWaste[index]),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement the action on Continue button press
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
