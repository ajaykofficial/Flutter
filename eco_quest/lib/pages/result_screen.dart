import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final List<String> correctCategorizations;
  final List<String> wrongCategorizations;

  const ResultScreen({
    Key? key,
    required this.correctCategorizations,
    required this.wrongCategorizations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Correct Categorizations: ${correctCategorizations.length}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              'Wrong Categorizations: ${wrongCategorizations.length}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
