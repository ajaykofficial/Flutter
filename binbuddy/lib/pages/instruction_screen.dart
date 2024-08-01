import 'package:binbuddy/widgets/InstructionPageWidget/build_Instructionstep.dart';
import 'package:flutter/material.dart';

class InstructionsPage extends StatelessWidget {
  const InstructionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'How  to  Play?',
          style: TextStyle(
              fontFamily: 'Norican-Regular',
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.limeAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/scbg.jpg'), // Add your background image
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Welcome to BINBUDDY!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto-Bold',
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 3.0,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Container(
              //   padding: const EdgeInsets.all(16.0),
              //   decoration: BoxDecoration(
              //       color: Colors.black.withOpacity(0.1),
              //       borderRadius: BorderRadius.circular(30)),
              //   child: const Text(
              //     'This game will help you learn how to sort waste correctly. Let\'s have fun while we learn!',
              //     style: TextStyle(
              //       fontWeight: FontWeight.w600,
              //       fontSize: 18,
              //       fontFamily: 'Roboto-Regular',
              //       color: Colors.white,
              //       // shadows: [
              //       //   Shadow(
              //       //     offset: const Offset(2.0, 1.0),
              //       //     blurRadius: 5.0,
              //       //     color: Colors.black.withOpacity(0.9),
              //       //   ),
              //       // ],
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 16.0),
              BuildInstructionStep(
                  context: context,
                  title: 'Level 1: Introduction to Waste Sorting',
                  imagePath: 'assets/images/level1.jpg',
                  description:
                      'Let\'s start with one waste item. Pick up the item and find the bin that matches the category of the item. Place the item into the correct bin. Great job!'),
              BuildInstructionStep(
                  context: context,
                  title: 'Level 2: Two Waste Items',
                  imagePath: 'assets/images/level2.jpg',
                  description:
                      'Now, we have two items. Look at each item carefully. Place each item into the correct bin. Remember to check the category of the bins. You can do it! Take your time and choose the right bin.'),
              BuildInstructionStep(
                  context: context,
                  title: 'Levels 3-5: Increasing Complexity',
                  imagePath: 'assets/images/level3.jpg',
                  description:
                      'We have more items to sort now. Look at each item. Place each item into the correct bin based on its category. If you\'re unsure, look at the category on the bins to help you decide. Let\'s see how many you can get right! You\'re doing great!'),
              BuildInstructionStep(
                  context: context,
                  title: 'Using the Bins',
                  imagePath: 'assets/images/trash-bin.png',
                  description:
                      'Approach the bin that you think is correct. Place the waste object into the bin with the matching category.'),
              BuildInstructionStep(
                  context: context,
                  title: 'Receiving Feedback',
                  imagePath: 'assets/images/binn1.png',
                  description:
                      'Positive Feedback: Well done! You sorted the waste correctly. Keep going!\nNegative Feedback: Oops! That\'s not the right bin. Try again and find the correct one.'),
              const SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, 'homeScreen');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.limeAccent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 16.0,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto-Regular',
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: Text(
                      'Start Playing',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: 'Roboto-Regular'),
                    ),
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
