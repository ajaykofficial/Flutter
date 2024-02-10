import 'package:eco_explorers/screens/map_screen.dart';
import 'package:flutter/material.dart';

class WasteDetectionScreen extends StatefulWidget {
  final List<MapImage> imageSet;

  WasteDetectionScreen({
    required this.imageSet,
  });

  @override
  _WasteDetectionScreenState createState() => _WasteDetectionScreenState();
}

class _WasteDetectionScreenState extends State<WasteDetectionScreen> {
  bool wasteDropped = false;
  bool nonWasteDropped = false;
  String feedbackText = '';
  Color feedbackColor = Colors.transparent;
  bool missionCompleted = false;
  late MapImage wasteImage;
  late MapImage nonWasteImage;

  @override
  void initState() {
    super.initState();
    wasteImage = widget.imageSet.firstWhere((image) => image.isWaste);
    nonWasteImage = widget.imageSet.firstWhere((image) => !image.isWaste);
  }

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
        backgroundColor: Color.fromARGB(255, 76, 255, 210),
        elevation: 4,
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
            if (wasteDropped || nonWasteDropped)
              Positioned(
                top: 30,
                left: 10,
                right: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
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
            Positioned(
              top: 180,
              right: 200,
              child: IgnorePointer(
                ignoring: missionCompleted,
                child: Draggable<bool>(
                  data: true,
                  feedback:
                      _buildImage(wasteImage.imagePath, 200, 200, opacity: 0.5),
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
                  child: _buildImage(wasteImage.imagePath, 200, 200),
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 210,
              child: IgnorePointer(
                ignoring: missionCompleted,
                child: Draggable<bool>(
                  data: false,
                  feedback: _buildImage(nonWasteImage.imagePath, 200, 200,
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
                  child: _buildImage(nonWasteImage.imagePath, 200, 200),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: MediaQuery.of(context).size.width / 2 - 150,
              child: DragTarget<bool>(
                onAccept: (bool isWaste) {
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
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/trash-bin.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (missionCompleted)
              Positioned(
                bottom: 10,
                left: 95,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => MapScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 11, 239, 231),
                      elevation: 4,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Go to Next Level',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
