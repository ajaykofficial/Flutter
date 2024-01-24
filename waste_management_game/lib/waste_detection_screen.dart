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
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              wasteObject.isWaste = true; // Marked as waste
                              categorizedWaste
                                  .add('Waste: ${wasteObject.imagePath}');
                            });
                          },
                          child: Text('Waste'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              wasteObject.isWaste =
                                  false; // Marked as non-waste
                              categorizedWaste
                                  .add('Non-Waste: ${wasteObject.imagePath}');
                            });
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
                            ? 'Correct Answer!'
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
