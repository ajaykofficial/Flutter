import 'package:flutter/material.dart';
import 'waste_detection_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        "assets/images/wel_bg.jpeg",
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [
          //       Color.fromARGB(255, 174, 232, 242),
          //       Color.fromARGB(255, 60, 4, 172),
          //     ],
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //   ),
          // ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Start Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 55),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the WasteDetectionScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WasteDetectionScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Color.fromARGB(255, 244, 241, 226),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Start Game',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
