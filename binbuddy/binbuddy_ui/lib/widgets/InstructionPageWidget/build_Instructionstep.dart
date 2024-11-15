import 'package:flutter/material.dart';

class BuildInstructionStep extends StatelessWidget {
  const BuildInstructionStep({
    super.key,
    required this.context,
    required this.title,
    required this.imagePath,
    required this.description,
  });

  final BuildContext context;
  final String title;
  final String imagePath;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  imagePath,
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto-Regular',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: const TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto-Regular',
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
