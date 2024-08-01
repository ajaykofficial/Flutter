import 'package:flutter/material.dart';

class BuildHighScoresButton extends StatelessWidget {
  const BuildHighScoresButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        // Navigator.pushNamed(context, 'highScores');
      },
      icon: const Icon(
        Icons.leaderboard,
        color: Colors.black,
      ),
      label: const Text('High Scores',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: const TextStyle(fontSize: 20),
      ),
    );
  }
}
