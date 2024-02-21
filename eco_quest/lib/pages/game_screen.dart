import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  final int numWasteImages;
  const GameScreen({Key? key, required this.numWasteImages}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List wasteImage = [
      (path: "assets/images/apple_waste.jpg", category: "Bio-Waste"),
      (path: "assets/images/apple_waste.jpg", category: "E-Waste"),
      (path: "assets/images/apple_waste.jpg", category: "Plastic-Waste"),
      (path: "assets/images/apple_waste.jpg", category: "Bio-Waste"),
      (path: "assets/images/apple_waste.jpg", category: "E-Waste"),
      (path: "assets/images/apple_waste.jpg", category: "Plastic-Waste"),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
        title: const Text(
          'Game Screen',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Norican-Regular'),
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
          ListView.builder(
              // scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {},
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          wasteImage[index].category,
                          style: const TextStyle(
                              fontFamily: 'Norican-Regular',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      leading: CircleAvatar(
                          radius: 30,
                          child: Image.asset(
                            '${wasteImage[index].path}',
                          )),
                    ),
                  ),
                );
              },
              itemCount: numWasteImages),
          Positioned(
            bottom: 50,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/reader_biowaste_bin.png',
                  width: 120,
                ),
                Image.asset(
                  'assets/images/reader_ewaste_bin.png',
                  width: 130,
                ),
                Image.asset(
                  'assets/images/reader_plasticwaste_bin.png',
                  width: 130,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
