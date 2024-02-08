import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  final ScrollController _controller =
      ScrollController(initialScrollOffset: 1700);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _controller,
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
              left: 150,
              bottom: 30,
              child: GestureDetector(
                onTap: () {
                  // Handle button press
                },
                child: Image.asset(
                  'assets/images/1.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Positioned(
              right: 70,
              bottom: 250,
              child: GestureDetector(
                onTap: () {
                  // Handle button press
                },
                child: Image.asset(
                  'assets/images/2.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Positioned(
              left: 70,
              bottom: 470,
              child: GestureDetector(
                onTap: () {
                  // Handle button press
                },
                child: Image.asset(
                  'assets/images/3.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Positioned(
              right: 110,
              bottom: 690,
              child: GestureDetector(
                onTap: () {
                  // Handle button press
                },
                child: Image.asset(
                  'assets/images/4.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            Positioned(
              right: 140,
              bottom: 950,
              child: GestureDetector(
                onTap: () {
                  // Handle button press
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
