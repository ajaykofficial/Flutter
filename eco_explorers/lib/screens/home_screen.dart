import 'package:eco_explorers/screens/map_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward().then((_) {
      _controller.stop(); // Stop the animation after it completes
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eco Explorers',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 209, 245, 178),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 255, 245, 230), // Light peach
              const Color.fromARGB(255, 200, 255, 200), // Light green
            ],
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              // Positioned image 1
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                top: MediaQuery.of(context).size.height * 0.30 - 40,
                left: MediaQuery.of(context).size.width * 0.5 - 40,
                child: ScaleTransition(
                  scale: _animation,
                  child: MissionImage(
                    imagePath: 'assets/images/binbutton1.png',
                    missionName: 'Mission 1',
                    onTap: () {
                      // Navigate to the MapScreen when Mission 1 is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapScreen()),
                      );
                    },
                  ),
                ),
              ),
              // Positioned image 2
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                top: MediaQuery.of(context).size.height * 0.65 - 80,
                left: MediaQuery.of(context).size.width * 0.15 - 40,
                child: ScaleTransition(
                  scale: _animation,
                  child: MissionImage(
                    imagePath: 'assets/images/binbutton2.png',
                    missionName: 'Mission 2',
                    onTap: () {
                      // Navigate to Mission 2 screen
                      Navigator.pushNamed(context, '/mission2');
                    },
                  ),
                ),
              ),
              // Positioned image 3
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                top: MediaQuery.of(context).size.height * 0.65 - 80,
                left: MediaQuery.of(context).size.width * 0.85 - 40,
                child: ScaleTransition(
                  scale: _animation,
                  child: MissionImage(
                    imagePath: 'assets/images/binbutton3.png',
                    missionName: 'Mission 3',
                    onTap: () {
                      // Navigate to Mission 3 screen
                      Navigator.pushNamed(context, '/mission3');
                    },
                  ),
                ),
              ),
              // Progress bar 1 (between Mission 1 and Mission 2)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.61 - 10,
                left: MediaQuery.of(context).size.width * 0.46 - 63,
                child: SizedBox(
                  width: 160,
                  height: 5,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              ),
              // Progress bar 2 (between Mission 2 and Mission 3)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.48 - 10,
                left: MediaQuery.of(context).size.width * 0.10 + 15,
                child: Transform.rotate(
                  angle: -1.047, // Rotate by -60 degrees (-pi/3 radians)
                  child: SizedBox(
                    width: 140,
                    height: 5,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                ),
              ),
              // Progress bar 3 (between Mission 1 and Mission 3)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.48 - 10,
                left: MediaQuery.of(context).size.width * 0.66 - 55,
                child: Transform.rotate(
                  angle: 1.047, // Rotate by 60 degrees (pi/3 radians)
                  child: SizedBox(
                    width: 140,
                    height: 5,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
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

class MissionImage extends StatelessWidget {
  final String imagePath;
  final String missionName;
  final VoidCallback onTap;

  MissionImage({
    required this.imagePath,
    required this.missionName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            missionName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
