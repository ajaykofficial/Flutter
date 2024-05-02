// import 'package:binbuddy/pages/bluetoothScanner.dart';
import 'package:binbuddy/pages/playerList.dart';
// import 'package:binbuddy/pages/result_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with semi-transparent overlay
          Stack(
            children: [
              Image.asset(
                'assets/images/scbg.jpg',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ],
          ),

          // Redesigned AppBar with gradient, rounded corners, and box shadows
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Colors.greenAccent,
                    Colors.blueAccent
                  ], // Gradient for eco-friendly theme
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(
                    30), // Rounded corners for a smooth look
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // IconButton(
                  //   icon: const Icon(Icons.arrow_back, color: Colors.black),
                  //   onPressed: () {
                  //     Navigator.pop(context); // Navigation for the back button
                  //   },
                  // ),

                  Text(
                    'Bin Buddy', // App title
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Norican-Regular',
                      color: Colors.black,
                    ),
                  ),
                  // IconButton(
                  //   icon: const Icon(Icons.settings,
                  //       color: Colors.black), // Settings button
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) =>
                  //             const SettingsScreen(), // Navigation to the settings screen
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                // Animated play button
                ScaleTransition(
                  scale: _animation,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlayerSelectionScreen(),
                        ),
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.redAccent, Colors.red],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.play_circle_filled,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Animated settings button
                // FadeTransition(
                //   opacity: _animation,
                //   child: ElevatedButton.icon(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => const SettingsScreen(),
                //         ),
                //       );
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.lightGreenAccent,
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 50, vertical: 20),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(30),
                //       ),
                //       shadowColor: Colors.black.withOpacity(0.3),
                //       elevation: 10,
                //     ),
                //     icon: const Icon(Icons.settings, color: Colors.black),
                //     label: const Text(
                //       'Settings',
                //       style: TextStyle(
                //         fontSize: 25,
                //         fontWeight: FontWeight.bold,
                //         fontFamily: 'Norican-Regular',
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20),
                // Animated result button
                FadeTransition(
                  opacity: _animation,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Navigator.push(
                      //     context, MaterialPageRoute(builder: (context) => ,));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreenAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: Colors.black.withOpacity(0.3),
                      elevation: 10,
                    ),
                    icon: const Icon(Icons.assessment, color: Colors.black),
                    label: const Text(
                      'Result',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Norican-Regular',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
