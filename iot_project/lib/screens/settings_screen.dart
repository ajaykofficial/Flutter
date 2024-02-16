import 'package:flutter/material.dart';
import 'package:iot_project/screens/bin_reader_configuration_screen.dart';
import 'package:iot_project/screens/reader_tag_configuration_screen.dart';
import 'package:iot_project/screens/tag_waste_configuration_screen.dart'; // Import the TagWasteConfigurationScreen

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade600,
        elevation: 4, // Add a subtle shadow effect
        centerTitle: true, // Center align the title
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 146, 244, 119),
              Color.fromARGB(255, 117, 216, 252),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 20.0,
          ), // Increased vertical padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement button functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Avatar Customization',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8), // Added spacing between text and icon
                  ],
                ),
              ),
              SizedBox(height: 20), // Increased spacing between buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Bin-Reader configuration screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BinReaderConfigurationScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.settings_input_component,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Bin-Reader Configuration',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8), // Added spacing between text and icon
                  ],
                ),
              ),
              SizedBox(height: 20), // Increased spacing between buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Reader-Tag configuration screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReaderTagConfigurationScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.label,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Reader-Tag Configuration',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8), // Added spacing between text and icon
                  ],
                ),
              ),
              SizedBox(height: 20), // Increased spacing between buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Tag-Waste configuration screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TagWasteConfigurationScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Tag-Waste Configuration',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8), // Added spacing between text and icon
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
