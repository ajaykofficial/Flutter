import 'package:eco_quest/pages/player_selection_screen.dart';
import 'package:eco_quest/pages/scanning_screen.dart'; // Import ScanningScreen
import 'package:eco_quest/pages/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Norican-Regular',
              color: Colors.black),
        ),
        backgroundColor: const Color.fromRGBO(252, 216, 116, 1),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            color: Colors.black,
            iconSize: 30,
            icon: const Icon(Icons.bluetooth),
            onPressed: () {
              // Navigate to scanning screen when Bluetooth icon is clicked
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScanningScreen()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/kid_bg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 50,
            left: 20,
            child: Container(
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
          Positioned(
            height: 70,
            width: 300,
            bottom: 290,
            left: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PlayerSelection(),
                  ),
                );
              },
              child: const Text(
                'Play',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Norican-Regular',
                ),
              ),
            ),
          ),
          Positioned(
            height: 70,
            width: 300,
            bottom: 180,
            left: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              child: const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Norican-Regular',
                ),
              ),
            ),
          ),
          Positioned(
            height: 70,
            width: 300,
            bottom: 80,
            left: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(), // button color
              onPressed: () {},
              child: const Text(
                'Result',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Norican-Regular',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
