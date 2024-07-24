import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LevelScreen extends StatelessWidget {
  final int unlockedLevels;

  const LevelScreen({
    Key? key,
    this.unlockedLevels = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allLevelImages = [
      'assets/images/level1.png',
      'assets/images/level2.png',
      'assets/images/level3.png',
      'assets/images/level4.png',
      'assets/images/level5.png',
      'assets/images/level6.png',
      'assets/images/level7.png',
      'assets/images/level1.png',
      'assets/images/level2.png',
      'assets/images/level3.png',
      'assets/images/level4.png',
      'assets/images/level5.png',
      'assets/images/level6.png',
      'assets/images/level7.png',
      'assets/images/level7.png',
      'assets/images/level7.png',
      'assets/images/level1.png',
      'assets/images/level2.png',
      'assets/images/level3.png',
      'assets/images/level4.png',
      'assets/images/level5.png',
      'assets/images/level6.png',
      'assets/images/level7.png',
      'assets/images/level7.png',
    ];

    final levelImages = List<String>.generate(
      allLevelImages.length,
      (index) => index < unlockedLevels
          ? allLevelImages[index]
          : 'assets/images/level-lock.png',
    );

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/d.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.greenAccent, Colors.blueAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  const Text(
                    'Select Level',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Norican-Regular',
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                ],
              ),
            ),
          ),
          _buildLevelGrid(context, levelImages),
        ],
      ),
    );
  }

  Widget _buildLevelGrid(BuildContext context, List<String> levelImages) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 140),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 4.0,
        mainAxisExtent: 150,
      ),
      itemCount: levelImages.length,
      itemBuilder: (context, index) {
        final isLevelUnlocked = index < unlockedLevels;

        return GestureDetector(
          onTap: () {
            if (isLevelUnlocked) {
              Navigator.pushNamed(context, 'gameScreen', arguments: index + 1);
            } else {
              _showLockedLevelDialog(context);
            }
          },
          child: Card(
            elevation: 4.0,
            child: Image.asset(
              levelImages[index],
            ),
          ),
        );
      },
    );
  }

  void _showLockedLevelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/animations/lock_animation.json',
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                'Level Locked!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }
}
