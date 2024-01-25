import 'package:flutter/material.dart';
import 'waste_categorizing_screen.dart';

class WasteObject {
  final String imagePath;
  bool? isWaste; // Nullable bool to represent not answered

  WasteObject({required this.imagePath, this.isWaste});
}

List<WasteObject> wasteObjects = [
  WasteObject(imagePath: 'assets/images/ewaste-mobile.png'),
  WasteObject(imagePath: 'assets/images/nonwaste-apple.png'),
  WasteObject(imagePath: 'assets/images/plasticwaste-bottle.png'),
  // Add more objects as needed
];

class WasteDetectionScreen extends StatefulWidget {
  @override
  _WasteDetectionScreenState createState() => _WasteDetectionScreenState();
}

class _WasteDetectionScreenState extends State<WasteDetectionScreen> {
  List<String> categorizedWaste = [];

  void _checkAnswer(WasteObject wasteObject, bool userAnswer) {
    if (wasteObject.isWaste == null) {
      if (wasteObject.isWaste == userAnswer) {
        // Correct answer, image will disappear
        setState(() {
          categorizedWaste.add('Waste: ${wasteObject.imagePath}');
          wasteObject.isWaste = true; // Mark the image as waste
        });
      } else {
        // Wrong answer, show "Try Again" dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Wrong Answer! Try Again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Try Again'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waste Detection'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display all images
            for (var wasteObject in wasteObjects)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Display the current image
                    Image.asset(
                      wasteObject.imagePath,
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(height: 20),

                    // Buttons to categorize waste or non-waste
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _checkAnswer(wasteObject, true);
                          },
                          child: Text('Waste'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _checkAnswer(wasteObject, false);
                          },
                          child: Text('Non-Waste'),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Indicate correct or wrong answer
                    if (wasteObject.isWaste != null)
                      Text(
                        wasteObject.isWaste!
                            ? 'Correct Answer! Image will disappear.'
                            : 'Wrong Answer! Try again.',
                        style: TextStyle(
                          color:
                              wasteObject.isWaste! ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                ),
              ),

            // Button to navigate to the WasteCategorizingScreen
            if (categorizedWaste.length == wasteObjects.length)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WasteCategorizingScreen(
                        categorizedWaste: categorizedWaste,
                      ),
                    ),
                  );
                },
                child: Text('Go to Waste Categorizing'),
              ),
          ],
        ),
      ),
    );
  }
}
