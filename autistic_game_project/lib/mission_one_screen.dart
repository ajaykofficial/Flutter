// mission_one_screen.dart
import 'package:flutter/material.dart';
import 'mission_two_screen.dart';

class MissionOneScreen extends StatefulWidget {
  @override
  _MissionOneScreenState createState() => _MissionOneScreenState();
}

class _MissionOneScreenState extends State<MissionOneScreen> {
  List<ImageItem> imageItems = [
    ImageItem('assets/images/plasticwaste-bottle.png', true),
    ImageItem('assets/images/nonwaste-apple.png', false),
    ImageItem('assets/images/ewaste-mobile.png', true),
    // Add more image items as needed
  ];

  int _currentPage = 0;
  bool _imageVisible = true;

  void _checkAnswer(bool isWaste) {
    if (imageItems[_currentPage].isWaste == isWaste) {
      _showPositiveResponse();
    } else {
      _showTryAgainDialog();
    }
  }

  void _showPositiveResponse() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Positive Response'),
          content: Text('Congratulations! Your answer is correct.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _imageVisible = true;
                  if (_currentPage < imageItems.length - 1) {
                    _currentPage++;
                  } else {
                    _showCompletionDialog();
                  }
                });
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showTryAgainDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Try Again'),
          content: Text('Incorrect! Try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mission Completed'),
          content: Column(
            children: [
              Text('Congratulations! You completed Mission One.'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MissionTwoScreen(
                            detectedWaste: List<String>.from(imageItems
                                .map((item) => item.isWaste.toString())),
                          ),
                        ),
                      );
                    },
                    child: Text('Next Mission'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.pushReplacementNamed(context, '/mission');
                    },
                    child: Text('Main Menu'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mission One: Waste Detection'),
        backgroundColor: Color(0xFFFDB813),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg1.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _imageVisible
                    ? Image.asset(
                        imageItems[_currentPage].imagePath,
                        fit: BoxFit.cover,
                      )
                    : Container(),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _checkAnswer(true),
                    child: Text('Waste'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => _checkAnswer(false),
                    child: Text('Non-Waste'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageItem {
  final String imagePath;
  final bool isWaste;

  ImageItem(this.imagePath, this.isWaste);
}
