import 'package:eco_quest/pages/game_screen.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        reverse: true,
        child: Stack(children: [
          Image.asset(
            'assets/images/map1.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 3,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 150,
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const GameScreen(numWasteImages: 1)));
              },
              child: Image.asset(
                'assets/images/button1.png',
              ),
            ),
          ),
          Positioned(
            left: 60,
            bottom: 400,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const GameScreen(numWasteImages: 2)));
              },
              child: Image.asset(
                'assets/images/button2.png',
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 800,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const GameScreen(numWasteImages: 3)));
              },
              child: Image.asset(
                'assets/images/button3.png',
              ),
            ),
          ),
          Positioned(
            left: 90,
            top: 1200,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const GameScreen(numWasteImages: 4)));
              },
              child: Image.asset(
                'assets/images/button4.png',
              ),
            ),
          ),
          Positioned(
            right: 50,
            top: 800,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const GameScreen(numWasteImages: 5)));
              },
              child: Image.asset(
                'assets/images/button5.png',
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
