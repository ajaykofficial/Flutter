import 'package:binbuddy/pages/assign_waste_screen.dart';
import 'package:flutter/material.dart';

class TagWasteConfigurationScreen extends StatelessWidget {
  const TagWasteConfigurationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tag-Waste Configuration',
          style: TextStyle(
              fontFamily: 'Norican-Regular',
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/kid_bg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 190,
                    height: 190,
                    child: Card(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AssignWasteScreen())),
                            child: Image.asset(
                              'assets/images/tag1.png',
                              width: 120,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Tag-1',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 190,
                    height: 190,
                    child: Card(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AssignWasteScreen())),
                            child: Image.asset(
                              'assets/images/tag1.png',
                              width: 120,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Tag-2',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 190,
                    height: 190,
                    child: Card(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AssignWasteScreen())),
                            child: Image.asset(
                              'assets/images/tag1.png',
                              width: 120,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Tag-3',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Card(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AssignWasteScreen())),
                            child: Image.asset(
                              'assets/images/tag1.png',
                              width: 120,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Tag-4',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 190,
                    height: 190,
                    child: Card(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AssignWasteScreen())),
                            child: Image.asset(
                              'assets/images/tag1.png',
                              width: 120,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Tag-5',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Card(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AssignWasteScreen())),
                            child: Image.asset(
                              'assets/images/tag1.png',
                              width: 120,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Tag-6',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
