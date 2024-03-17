import 'dart:async';
import 'package:eco_quest/pages/level_screen.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final int numWasteImages;
  const GameScreen({
    Key? key,
    required this.numWasteImages,
    required String levelParameter,
  }) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<bool> wasteImageVisibility =
      List.generate(6, (_) => true); // Track visibility of each waste image
  int selectedBioBinIndex = -1;
  int selectedEWasteBinIndex = -1;
  int selectedPlasticWasteBinIndex = -1;
  String feedbackText = '';
  int droppedWasteImagesCount = 0; // Track the number of dropped waste images
  List<String> correctCategorizations = [];
  List<String> wrongCategorizations = [];

  List<Map<String, dynamic>> wasteImage = [
    {"path": "assets/images/apple_waste.png", "category": "Bio-Waste"},
    {"path": "assets/images/ewaste_computer.png", "category": "E-Waste"},
    {
      "path": "assets/images/plastic_bottle_waste.png",
      "category": "Plastic-Waste"
    },
    {"path": "assets/images/banana_peel.png", "category": "Bio-Waste"},
    {"path": "assets/images/broken_phone.png", "category": "E-Waste"},
    {"path": "assets/images/red_can.png", "category": "Plastic-Waste"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        title: const Text(
          'Game Screen',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Norican-Regular',
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/kids-library_bg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 200,
                crossAxisCount: 2,
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
              ),
              itemBuilder: (context, index) {
                return wasteImageVisibility[index]
                    ? Draggable(
                        data: wasteImage[index]["category"],
                        feedback: Image.asset(
                          wasteImage[index]["path"],
                          width: 120,
                        ),
                        childWhenDragging: Container(),
                        onDragStarted: () {
                          setState(() {
                            // Track the index of the dragged waste image
                          });
                        },
                        onDragEnd: (details) {
                          if (details.wasAccepted) {
                            setState(() {
                              // Hide the dropped waste image
                              wasteImageVisibility[index] = false;
                              droppedWasteImagesCount++;

                              // Check if all waste images are dropped
                              if (droppedWasteImagesCount ==
                                  widget.numWasteImages) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(30.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.white,
                                              Colors.lightBlueAccent,
                                            ],
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              'Level Complete!',
                                              style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Congratulations!',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 30),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 30),
                                                backgroundColor:
                                                    Colors.amberAccent,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LevelScreen(),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'Go To Next Level',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            });
                          } else {
                            setState(() {
                              // Record wrong categorization
                              wrongCategorizations
                                  .add(wasteImage[index]["category"]);
                            });
                          }
                        },
                        child: Card(
                          color: Colors.white.withOpacity(0.8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              wasteImage[index]["path"],
                            ),
                          ),
                        ),
                      )
                    : Container();
              },
              itemCount: widget.numWasteImages,
            ),
          ),
          Positioned(
            bottom: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildWasteBin(0, "Bio-Waste"),
                buildWasteBin(1, "E-Waste"),
                buildWasteBin(2, "Plastic-Waste"),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: feedbackText.isNotEmpty ? 1.0 : 0.0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: feedbackText.startsWith('Correct')
                      ? Colors.green
                      : Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  feedbackText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWasteBin(int index, String category) {
    return DragTarget(
      onAccept: (String? itemCategory) {
        setState(() {
          if (itemCategory == category) {
            // Positive feedback if the waste and bin categories match
            feedbackText = 'Correct Category!';
            correctCategorizations
                .add(category); // Record correct categorization
          } else {
            // Negative feedback if the waste and bin categories don't match
            feedbackText = 'Incorrect Category!';
            wrongCategorizations
                .add(itemCategory!); // Record wrong categorization
          }
          // Start a timer to clear the feedback after 2 seconds
          Timer(const Duration(seconds: 2), () {
            setState(() {
              feedbackText = '';
            });
          });
        });
      },
      builder:
          (BuildContext context, List<String?> candidateData, rejectedData) {
        return GestureDetector(
          onTap: () {
            setState(() {
              switch (category) {
                case "Bio-Waste":
                  selectedBioBinIndex = index;
                  break;
                case "E-Waste":
                  selectedEWasteBinIndex = index;
                  break;
                case "Plastic-Waste":
                  selectedPlasticWasteBinIndex = index;
                  break;
                default:
                  break;
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: getBinColor(index, category),
            ),
            height: 130,
            width: 130,
            child: Image.asset(
              'assets/images/reader_${category.toLowerCase().replaceAll("-", "")}_bin.png',
              width: 120,
            ),
          ),
        );
      },
    );
  }

  Color? getBinColor(int index, String category) {
    switch (category) {
      case "Bio-Waste":
        return selectedBioBinIndex == index ? Colors.greenAccent : null;
      case "E-Waste":
        return selectedEWasteBinIndex == index ? Colors.yellowAccent : null;
      case "Plastic-Waste":
        return selectedPlasticWasteBinIndex == index ? Colors.blueAccent : null;
      default:
        return null;
    }
  }
}
