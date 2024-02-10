import 'package:eco_explorers/screens/waste_detection_screen.dart';
import 'package:flutter/material.dart';
import 'map_screen.dart'; // Import your map screen file

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Stack(
          children: [
            // Full-screen image background
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 3,
              child: Image.asset(
                'assets/images/map1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // Positioned buttons within the image
            Positioned(
              left: MediaQuery.of(context).size.width * 0.4,
              bottom: MediaQuery.of(context).size.height * 0.05,
              child: GestureDetector(
                onTap: () {
                  // Handle button 1 press
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WasteDetectionScreen(
                              imageSet: [
                                MapImage(
                                  imagePath: 'assets/images/apple_nonwaste.png',
                                  isWaste: false,
                                ),
                                MapImage(
                                  imagePath: 'assets/images/apple_waste.png',
                                  isWaste: true,
                                ),
                              ],
                            )),
                  );
                },
                child: Image.asset(
                  'assets/images/1.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.25,
              bottom: MediaQuery.of(context).size.height * 0.33,
              child: GestureDetector(
                onTap: () {
                  // Handle button 2 press
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WasteDetectionScreen(
                              imageSet: [
                                MapImage(
                                  imagePath:
                                      'assets/images/plastic_bottle_waste.png',
                                  isWaste: true,
                                ),
                                MapImage(
                                  imagePath:
                                      'assets/images/plastic_bottle_nonwaste.png',
                                  isWaste: false,
                                ),
                              ],
                            )),
                  );
                },
                child: Image.asset(
                  'assets/images/2.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width * 0.15,
              bottom: MediaQuery.of(context).size.height * 0.55,
              child: GestureDetector(
                onTap: () {
                  // Handle button 3 press
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WasteDetectionScreen(
                              imageSet: [
                                MapImage(
                                  imagePath: 'assets/images/apple_waste.png',
                                  isWaste: true,
                                ),
                                MapImage(
                                  imagePath: 'assets/images/apple_nonwaste.png',
                                  isWaste: false,
                                ),
                              ],
                            )),
                  );
                },
                child: Image.asset(
                  'assets/images/3.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.30,
              bottom: MediaQuery.of(context).size.height * 0.80,
              child: GestureDetector(
                onTap: () {
                  // Handle button 4 press
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WasteDetectionScreen(
                              imageSet: [
                                MapImage(
                                  imagePath: 'assets/images/apple_nonwaste.png',
                                  isWaste: false,
                                ),
                                MapImage(
                                  imagePath: 'assets/images/apple_waste.png',
                                  isWaste: true,
                                ),
                              ],
                            )),
                  );
                },
                child: Image.asset(
                  'assets/images/4.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.41,
              bottom: MediaQuery.of(context).size.height * 1.15,
              child: GestureDetector(
                onTap: () {
                  // Handle button 5 press
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WasteDetectionScreen(
                              imageSet: [
                                MapImage(
                                  imagePath: 'assets/images/apple_nonwaste.png',
                                  isWaste: false,
                                ),
                                MapImage(
                                  imagePath: 'assets/images/apple_waste.png',
                                  isWaste: true,
                                ),
                              ],
                            )),
                  );
                },
                child: Image.asset(
                  'assets/images/5.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapImage {
  final String imagePath;
  final bool isWaste;

  MapImage({
    required this.imagePath,
    required this.isWaste,
  });
}
