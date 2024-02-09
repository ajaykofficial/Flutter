import 'package:flutter/material.dart';
import 'map_screen.dart'; // Import your map screen file

class WasteDetectionScreen extends StatefulWidget {
  @override
  _WasteDetectionScreenState createState() => _WasteDetectionScreenState();
}

class _WasteDetectionScreenState extends State<WasteDetectionScreen> {
  // Track whether the waste and non-waste images are dropped in the waste basket
  bool wasteDropped = false;
  bool nonWasteDropped = false;
  String feedbackText = '';
  Color feedbackColor = Colors.transparent;
  bool missionCompleted =
      false; // Flag to track whether the mission is completed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Waste Detection',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(
            255, 76, 255, 210), // Background color of the app bar
        elevation: 4, // Elevation of the app bar shadow
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 102, 239, 106),
              const Color.fromARGB(255, 38, 215, 247),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Feedback Container
            if (wasteDropped || nonWasteDropped)
              Positioned(
                top: 30,
                left: 10,
                right: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      20), // Adjust border radius as needed
                  child: Container(
                    color: feedbackColor,
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          feedbackText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            // Waste Image
            Positioned(
              top: 180, // Adjust top position as needed
              right: 210, // Adjust left position as needed
              child: IgnorePointer(
                ignoring: missionCompleted,
                child: Draggable<bool>(
                  data: true, // Indicate that this is a waste image
                  child: _buildImage('assets/images/apple_waste.png', 200, 200),
                  feedback: _buildImage(
                      'assets/images/apple_waste.png', 200, 200,
                      opacity: 0.5),
                  childWhenDragging: SizedBox(),
                  onDragEnd: (details) {
                    if (details.wasAccepted && !missionCompleted) {
                      setState(() {
                        feedbackText = 'Well Done!😀';
                        feedbackColor = Color.fromARGB(255, 56, 206, 61);
                        wasteDropped = true;
                        missionCompleted = true;
                      });
                    }
                  },
                ),
              ),
            ),
// Non-Waste Image
            Positioned(
              top: 180, // Adjust top position as needed
              left: 210, // Adjust right position as needed
              child: IgnorePointer(
                ignoring: missionCompleted,
                child: Draggable<bool>(
                  data: false, // Indicate that this is a non-waste image
                  child:
                      _buildImage('assets/images/apple_nonwaste.png', 200, 200),
                  feedback: _buildImage(
                      'assets/images/apple_nonwaste.png', 200, 200,
                      opacity: 0.5),
                  childWhenDragging: SizedBox(),
                  onDragEnd: (details) {
                    if (details.wasAccepted && !missionCompleted) {
                      setState(() {
                        feedbackText = 'Oops! 🤔';
                        feedbackColor = Colors.red;
                        nonWasteDropped = true;
                      });
                    }
                  },
                ),
              ),
            ),
            // Waste Basket
            Positioned(
              bottom: 50, // Adjust bottom position as needed
              left: MediaQuery.of(context).size.width / 2 -
                  150, // Center horizontally
              child: DragTarget<bool>(
                onAccept: (bool isWaste) {
                  // Check if waste or non-waste image was dropped and update state accordingly
                  if (isWaste) {
                    setState(() {
                      wasteDropped = true;
                      feedbackText = 'Well Done! 😀';
                      feedbackColor = Colors.green;
                    });
                  } else {
                    setState(() {
                      nonWasteDropped = true;
                      feedbackText = 'Oops! 🤔';
                      feedbackColor = Colors.red;
                    });
                  }
                },
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/trash-bin.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Next Level Button
            if (missionCompleted)
              Positioned(
                bottom: 10,
                left: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the next level (Assuming `MapScreen` is your map screen)
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MapScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color.fromARGB(255, 230, 238, 244), // Button color
                      elevation: 4, // Elevation of the button shadow
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Button border radius
                      ),
                    ),
                    child: Text(
                      'Go to Next Level',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath, double width, double height,
      {double opacity = 1.0}) {
    return Opacity(
      opacity: opacity,
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
      ),
    );
  }
}
