import 'package:binbuddy/pages/settings_screen.dart';
import 'package:flutter/material.dart';

class BinReaderConfigurationScreen extends StatelessWidget {
  const BinReaderConfigurationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bin-Reader Configuration',
          style: TextStyle(
            fontFamily: 'Norican-Regular',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
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
          Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                const BinCardWithButtons(
                  imagePath: 'assets/images/reader_biowaste_bin.png',
                ),
                const SizedBox(height: 20), // Add space below the card
                const BinCardWithButtons(
                  imagePath: 'assets/images/reader_ewaste_bin.png',
                ),
                const SizedBox(height: 20), // Add space below the card
                const BinCardWithButtons(
                  imagePath: 'assets/images/reader_plasticwaste_bin.png',
                ),
                const SizedBox(height: 20), // Add space below the card
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SettingsScreen(),
                        ),
                        (route) => route.isFirst,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    child: const Text(
                      'Configuration',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                    height: 20), // Add space below the configuration button
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BinCardWithButtons extends StatefulWidget {
  final String imagePath;

  const BinCardWithButtons({Key? key, required this.imagePath})
      : super(key: key);

  @override
  _BinCardWithButtonsState createState() => _BinCardWithButtonsState();
}

class _BinCardWithButtonsState extends State<BinCardWithButtons> {
  Color? _selectedColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250, // Adjust the height to accommodate larger images
          child: Card(
            color: _selectedColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                widget.imagePath,
                fit: BoxFit.contain, // Maintain aspect ratio
              ),
            ),
          ),
        ),
        const SizedBox(height: 20), // Add space below the card
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedColor = Colors.lightGreenAccent;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  backgroundColor: Colors.lightGreenAccent,
                ),
                child: const Text(
                  'Bio Waste',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 20), // Add space between buttons
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedColor = Colors.lightBlueAccent;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.lightBlueAccent,
                ),
                child: const Text(
                  'E Waste',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(width: 20), // Add space between buttons
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedColor = Colors.redAccent;
                  });
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text(
                  'Plastic Waste',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
