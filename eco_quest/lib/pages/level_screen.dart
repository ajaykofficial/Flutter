import 'package:flutter/material.dart';
import 'package:eco_quest/pages/game_screen.dart';

class LevelScreen extends StatelessWidget {
  const LevelScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    // Mock list of level images
    List<String> levelImages = [
      'assets/images/level1.png',
      'assets/images/level2.png',
      'assets/images/level3.png',
      'assets/images/level4.png',
      'assets/images/level5.png',
      'assets/images/level-lock.png',
      'assets/images/level-lock-leaf.png',
      'assets/images/level-lock.png',
      'assets/images/level-lock.png',
      'assets/images/level-lock-leaf.png',
      'assets/images/level-lock.png',
      'assets/images/level-lock.png',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Select Level',
          style: TextStyle(
            fontFamily: 'Norican-Regular',
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/young-student_bg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          GridView.builder(
            padding: const EdgeInsets.only(top: 20.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 170,
              crossAxisCount: 3,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
            ),
            itemCount: levelImages.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  if (index < 5) {
                    // Define parameters for different levels
                    Map<int, String> levelParameters = {
                      0: '1',
                      1: '2',
                      2: '3',
                      3: '4',
                      4: '5',
                      // Add more parameters for additional levels as needed
                    };

                    // Navigate to the same screen with different parameters
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GameScreen(
                          numWasteImages: int.parse(levelParameters[index]!),
                          levelParameter: '',
                        ),
                      ),
                    );
                  }
                },
                child: Card(
                  elevation: 4.0,
                  clipBehavior: Clip.none,
                  child: Image.asset(
                    levelImages[index],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
