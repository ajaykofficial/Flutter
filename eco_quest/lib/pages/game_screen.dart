import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  final int numWasteImages;
  const GameScreen(
      {Key? key, required this.numWasteImages, required String levelParameter})
      : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int selectedWasteIndex = -1;
  int selectedBioBinIndex = -1;
  int selectedEWasteBinIndex = -1;
  int selectedPlasticWasteBinIndex = -1;

  @override
  Widget build(BuildContext context) {
    List wasteImage = [
      (path: "assets/images/apple_waste.png", category: "Bio-Waste"),
      (path: "assets/images/ewaste_computer.png", category: "E-Waste"),
      (
        path: "assets/images/plastic_bottle_waste.png",
        category: "Plastic-Waste"
      ),
      (path: "assets/images/banana_peel.png", category: "Bio-Waste"),
      (path: "assets/images/broken_phone.png", category: "E-Waste"),
      (path: "assets/images/red_can.png", category: "Plastic-Waste"),
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 150,
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 30),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedWasteIndex = index;
                    });
                  },
                  child: Card(
                    color: selectedWasteIndex == index
                        ? Colors.amber
                        : Colors.white.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        wasteImage[index].path,
                      ),
                    ),
                  ),
                );
              },
              itemCount: widget.numWasteImages,
            ),
          ),
          Positioned(
            bottom: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBioBinIndex = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          selectedBioBinIndex == 0 ? Colors.greenAccent : null,
                    ),
                    height: 130,
                    width: 130,
                    child: Image.asset(
                      'assets/images/reader_biowaste_bin.png',
                      width: 120,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedEWasteBinIndex = 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedEWasteBinIndex == 1
                          ? Colors.yellowAccent
                          : null,
                    ),
                    height: 130,
                    width: 130,
                    child: Image.asset(
                      'assets/images/reader_ewaste_bin.png',
                      width: 130,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPlasticWasteBinIndex = 2;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedPlasticWasteBinIndex == 2
                          ? Colors.blueAccent
                          : null,
                    ),
                    height: 130,
                    width: 130,
                    child: Image.asset(
                      'assets/images/reader_plasticwaste_bin.png',
                      width: 130,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
