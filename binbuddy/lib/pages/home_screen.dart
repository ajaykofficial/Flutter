import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  bool canPop = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvoked: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: [
            _buildBackground(),
            _buildTitle(),
            _buildMainContent(context),
            // _buildSettingsButton(),
            // _buildProfileAvatar(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Image.asset(
          'assets/images/scbg.jpg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          gaplessPlayback: true,
        ),
        Container(
          color: Colors.black.withOpacity(0.1),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Positioned(
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
        child: const Center(
          child: Text(
            'Bin Buddy',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Norican-Regular'),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 80),
          ScaleTransition(
            scale: _animation,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'playerList');
              },
              child: _buildPlayButton(),
            ),
          ),
          const SizedBox(height: 30),
          _buildInstructionsButton(),
          const SizedBox(height: 10),
          _buildHighScoresButton(),
        ],
      ),
    );
  }

  Widget _buildPlayButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.redAccent, Colors.red],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
    );
  }

  Widget _buildInstructionsButton() {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, 'instructions');
      },
      icon: const Icon(Icons.help, color: Colors.black),
      label: const Text('How to Play',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orangeAccent,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: const TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _buildHighScoresButton() {
    return ElevatedButton.icon(
      onPressed: () {
        // Navigator.pushNamed(context, 'highScores');
      },
      icon: const Icon(
        Icons.leaderboard,
        color: Colors.black,
      ),
      label: const Text('High Scores',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: const TextStyle(fontSize: 20),
      ),
    );
  }

  // Widget _buildSettingsButton() {
  //   return Positioned(
  //     top: 50,
  //     right: 30,
  //     child: IconButton(
  //       icon: const Icon(Icons.settings, color: Colors.white, size: 30),
  //       onPressed: () {
  //         Navigator.pushNamed(context, 'settings');
  //       },
  //     ),
  //   );
  // }

  // Widget _buildProfileAvatar() {
  //   return Positioned(
  //     top: 50,
  //     left: 30,
  //     child: GestureDetector(
  //       onTap: () {
  //         Navigator.pushNamed(context, 'profile');
  //       },
  //       child: const CircleAvatar(
  //         radius: 30,
  //         backgroundImage: AssetImage('assets/images/avatar-image1.png'),
  //       ),
  //     ),
  //   );
  // }

  void _onWillPop(bool canPop) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFECBB), Color(0xFFFFD54F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFECBB), Color(0xFFFFD54F)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border:
                        Border.all(color: const Color(0xFFFFA000), width: 2),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF6F00),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Exit App",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6F00),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Are you sure you want to exit the app?",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6F00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6F00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () => SystemNavigator.pop(),
                      child: const Text("Exit",
                          style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
