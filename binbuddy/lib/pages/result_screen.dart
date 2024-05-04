import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final int level;
  final int correctSorts;
  final int incorrectSorts;
  final int totalTagsRead;

  const ResultsScreen({
    Key? key,
    required this.level,
    required this.correctSorts,
    required this.incorrectSorts,
    required this.totalTagsRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level $level Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Results for Level $level',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildResultMetric('Correct Sorts', correctSorts),
            _buildResultMetric('Incorrect Sorts', incorrectSorts),
            _buildResultMetric('Total Tags Read', totalTagsRead),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Return to the previous screen
                  },
                  child: const Text('Main Menu'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Logic to proceed to the next level
                    Navigator.pop(context); // For demonstration, pop back
                  },
                  child: const Text('Next Level'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultMetric(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
