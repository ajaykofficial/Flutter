import 'package:flutter/material.dart';

class BuildInstructionsButton extends StatelessWidget {
  const BuildInstructionsButton({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, 'instructions');
      },
      icon: const Icon(Icons.help, color: Colors.black),
      label: const Text('How to Play',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orangeAccent,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: const TextStyle(fontSize: 20),
      ),
    );
  }
}
