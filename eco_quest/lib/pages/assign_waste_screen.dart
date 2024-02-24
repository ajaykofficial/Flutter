import 'package:flutter/material.dart';

class AssignWasteScreen extends StatelessWidget {
  const AssignWasteScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Assign Waste',
          style: TextStyle(
            fontFamily: 'Norican-Regular',
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/young-student_bg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          _buildWasteList(),
        ],
      ),
    );
  }

  Widget _buildWasteList() {
    return ListView.builder(
      itemCount: wasteImages.length,
      itemBuilder: (context, index) {
        return _buildWasteCard(
          wasteImages[index]['path']!,
          wasteImages[index]['category']!,
        );
      },
    );
  }

  Widget _buildWasteCard(String imagePath, String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: SizedBox(
        height: 200,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Category:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          category,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Map<String, String>> wasteImages = [
  {'path': 'assets/images/apple_waste.png', 'category': 'Bio-waste'},
  {'path': 'assets/images/broken_phone.png', 'category': 'E-waste'},
  {
    'path': 'assets/images/plastic_bottle_waste.png',
    'category': 'Plastic-waste'
  },
  {'path': 'assets/images/banana_peel.png', 'category': 'Bio-waste'},
  {'path': 'assets/images/ewaste_computer.png', 'category': 'E-waste'},
  {'path': 'assets/images/red_can.png', 'category': 'Plastic-waste'},
];
