import 'package:binbuddy/pages/home_screen.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final int level;
  final int correctSorts;
  final int incorrectSorts;

  const ResultsScreen({
    Key? key,
    required this.level,
    required this.correctSorts,
    required this.incorrectSorts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.white], // Gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          // Ensures content doesn't overlap with system UI
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center-aligning content
            children: [
              AppBar(
                title: Text('Level $level Results'),
                backgroundColor:
                    Colors.transparent, // Transparent for gradient effect
                elevation: 0, // No shadow for clean appearance
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // Return to previous screen
                  },
                ),
              ),
              Expanded(
                // To allow content to expand and scroll
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center-aligning content
                    children: [
                      Text(
                        'Results for Level $level',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 16), // Spacing between elements
                      _buildResultMetric('Correct Sorts', correctSorts,
                          Colors.green), // Highlight with color
                      _buildResultMetric('Incorrect Sorts', incorrectSorts,
                          Colors.red), // Highlight with color
                      const SizedBox(height: 32),
                      const Divider(
                          color: Colors.grey), // Separator for visual clarity
                      const SizedBox(height: 16),
                      _buildNavigationButtons(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultMetric(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center-aligning metrics
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color, // Highlighting with color
            ),
          ),
          const SizedBox(width: 8), // Spacing between text elements
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 22,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Center(
      // Aligning buttons at the center
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Evenly spaced
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const HomeScreen(),
                ),
                (route) => route.isFirst,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent, // Color styling
            ),
            child: const Text(
              'Main Menu',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const HomeScreen(),
                ),
                (route) => route.isFirst,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Color styling
            ),
            child: const Text(
              'Next Level',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
