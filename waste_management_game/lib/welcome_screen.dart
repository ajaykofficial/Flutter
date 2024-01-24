import 'package:flutter/material.dart';
import 'waste_detection_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 174, 232, 242),
              Color.fromARGB(255, 60, 4, 172),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo in round shape
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/logo_binandchild.png',
                    width: 250,
                    height: 250,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Game Name
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'EcoLearn',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 1.0),
                child: Text(
                  'Waste Management Adventure',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),

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
                    backgroundColor: Color.fromARGB(255, 190, 232, 239),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
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
              // Welcome Message
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  'Welcome to an Eco-Friendly Learning Experience',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 202, 206, 242),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
