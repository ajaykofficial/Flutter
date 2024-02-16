import 'package:flutter/material.dart';
import 'package:iot_project/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Waste Management Game',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Change text color to white
          ),
        ),
        backgroundColor: Colors.tealAccent[700], // Set app bar background color
        elevation: 0, // Remove elevation for a flatter look
        centerTitle: true, // Center the title
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 134, 246, 112),
              Color.fromARGB(255, 103, 214, 250)
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigate to the game screen
                  // Replace this with your game screen implementation
                  print('Navigate to Game Screen');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 40.0), // Increase button padding
                  child: Text(
                    'Play Game',
                    style: TextStyle(
                      fontSize: 24, // Increase font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Change button color to blue
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        40), // Increase button border radius
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the IoT configuration screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 50.0), // Increase button padding
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 24, // Increase font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.orangeAccent, // Change button color to orange
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        40), // Increase button border radius
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
