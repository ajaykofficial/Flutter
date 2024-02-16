import 'package:flutter/material.dart';
import 'package:iot_project/screens/settings_screen.dart';

class BinReaderConfigurationScreen extends StatefulWidget {
  @override
  _BinReaderConfigurationScreenState createState() =>
      _BinReaderConfigurationScreenState();
}

class _BinReaderConfigurationScreenState
    extends State<BinReaderConfigurationScreen> {
  // Map to store the selected reader for each bin
  Map<String, String?> selectedReaders = {
    'Bin 1': null, // Initialize with null
    'Bin 2': null, // Initialize with null
    'Bin 3': null, // Initialize with null
  };

  // List of images for bins
  List<String> binImages = [
    'assets/images/reader_biowaste_bin.png',
    'assets/images/reader_plasticwaste_bin.png',
    'assets/images/reader_ewaste_bin.png',
  ];

  // List of readers and corresponding colors
  Map<String, Color> readerOptions = {
    'Reader 1': Colors.blue,
    'Reader 2': Colors.green,
    'Reader 3': Colors.orange,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bin Reader Configuration',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue, // Set app bar color
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF00AEEF),
              Color.fromARGB(255, 229, 226, 22),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBinWidget('Bin 1', binImages[0]),
                    _buildBinWidget('Bin 2', binImages[1]),
                    _buildBinWidget('Bin 3', binImages[2]),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Implement save configuration logic
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsScreen()),
                      );
                      print('Configuration Saved!');
                      print(selectedReaders);
                    },
                    child: Text(
                      'Save Configuration',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(
                          255, 122, 220, 247), // Set button color
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

  Widget _buildBinWidget(String bin, String imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: selectedReaders[bin]?.isNotEmpty == true
                ? readerOptions[selectedReaders[bin]] ?? Colors.yellow
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(40),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Wrap(
          alignment: WrapAlignment.center,
          children: readerOptions.keys.map((reader) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedReaders[bin] = reader;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: readerOptions[reader],
                ),
                child: Text(
                  reader,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
