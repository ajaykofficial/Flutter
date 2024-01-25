import 'package:flutter/material.dart';
import 'mission_screen.dart';

class OpeningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg1.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: Colors.white),
            ),
            margin: EdgeInsets.only(top: 300, bottom: 70, left: 20, right: 20),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Your circular game logo or image
                ClipOval(
                  child: Container(
                    color: Colors.white,
                    child: Image.asset('assets/images/s1.jpeg', height: 200),
                  ),
                ),
                SizedBox(height: 20),
                // Game title
                Text(
                  'Waste Management Game',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                // Start button with sunrise colors
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFFFDB813), // Sunrise color
                    elevation: 5,
                    textStyle: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        width: 3,
                        color: Colors.amber.shade200,
                      ),
                    ),
                  ),
                  onPressed: () {
                    // Add navigation logic to transition to the MissionScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MissionScreen()),
                    );
                  },
                  child: Text('Start Game'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
