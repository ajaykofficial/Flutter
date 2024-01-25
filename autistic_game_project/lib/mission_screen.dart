// mission_screen.dart
import 'package:flutter/material.dart';
import 'mission_one_screen.dart';
import 'mission_two_screen.dart';
import 'mission_three_screen.dart';

class MissionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/s2.jpeg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 270, 20, 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFFFDB813),
                    elevation: 5,
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        width: 2,
                        color: Colors.amber.shade200,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MissionOneScreen(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🔍', style: TextStyle(fontSize: 50)),
                      SizedBox(width: 10),
                      Text('Mission One',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 20), // Add space between buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFFFDB813),
                    elevation: 5,
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        width: 2,
                        color: Colors.amber.shade200,
                      ),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to Mission Two Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MissionTwoScreen(
                          detectedWaste: [], // Initialize with an empty list
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🔄', style: TextStyle(fontSize: 50)),
                      SizedBox(width: 10),
                      Text('Mission Two',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 20), // Add space between buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFFFDB813),
                    elevation: 5,
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        width: 2,
                        color: Colors.amber.shade200,
                      ),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to Mission Three Screen with an empty list for categorizedWaste
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MissionThreeScreen(categorizedWaste: []),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🗑️', style: TextStyle(fontSize: 50)),
                      SizedBox(width: 10),
                      Text('Mission Three',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 20), // Add space between buttons
              ],
            ),
          ),
        ),
      ),
    );
  }
}
