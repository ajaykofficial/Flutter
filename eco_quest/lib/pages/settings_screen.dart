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
          'assets/images/kids-library_bg.jpg',
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
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Avatar Customization',
                        style: TextStyle(
                            // fontFamily: 'Norican-Regular',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Bin-Reader Configuration',
                        style: TextStyle(
                            // fontFamily: 'Norican-Regular',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Reader-Tag Configuration',
                        style: TextStyle(
                            // fontFamily: 'Norican-Regular',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Tag-Waste Configuration',
                        style: TextStyle(
                            // fontFamily: 'Norican-Regular',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
