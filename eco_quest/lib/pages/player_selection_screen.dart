import 'package:eco_quest/pages/level_screen.dart';
import 'package:flutter/material.dart';

class PlayerSelection extends StatelessWidget {
  const PlayerSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Player Selection',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Norican-Regular',
              color: Colors.black),
        ),
        backgroundColor: const Color.fromRGBO(252, 216, 116, 1),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/boy_bg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 80,
            left: 20,
            child: Container(
              height: 300,
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
            bottom: 250,
            left: 45,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LevelScreen()));
                },
                child: const Text(
                  'Single Player',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Norican-Regular'),
                )),
          ),
          Positioned(
            height: 70,
            width: 300,
            bottom: 150,
            left: 45,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Multiplayer',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Norican-Regular'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
