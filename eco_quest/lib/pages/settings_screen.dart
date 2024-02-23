import 'package:eco_quest/pages/avatar_customization_screen.dart';
import 'package:eco_quest/pages/bin_reader_configuration_screen.dart';
import 'package:eco_quest/pages/reader_tag_configuration_screen.dart';
import 'package:eco_quest/pages/tag_waste_configuration_screen.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
              fontFamily: 'Norican-Regular',
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Stack(children: [
        Image.asset(
          'assets/images/kids-running-water_bg.jpg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 70,
          left: 30,
          child: Container(
            width: 350,
            height: 350,
            // color: Colors.white.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AvatarCustomization()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amberAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                    ),
                    child: const Text(
                      'Avatar Customization',
                      style: TextStyle(
                          color: Colors.white,
                          // fontFamily: 'Solgas',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  BinReaderConfigurationScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20)),
                    child: const Text(
                      'Bin-Reader Configuration',
                      style: TextStyle(
                          color: Colors.white,
                          // fontFamily: 'Norican-Regular',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ReaderTagConfigurationScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20)),
                    child: const Text(
                      'Reader-Tag Configuration',
                      style: TextStyle(
                          color: Colors.white,
                          // fontFamily: 'Norican-Regular',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TagWasteConfigurationScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20)),
                    child: const Text(
                      'Tag-Waste Configuration',
                      style: TextStyle(
                          color: Colors.white,
                          // fontFamily: 'Norican-Regular',
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
