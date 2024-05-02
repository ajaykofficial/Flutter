import 'package:binbuddy/pages/levelScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:binbuddy/pages/bluetoothScanner.dart';

class PlayerSelectionScreen extends StatefulWidget {
  const PlayerSelectionScreen({Key? key}) : super(key: key);

  @override
  _PlayerSelectionScreenState createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
  String _selectedPlayerName = '';
  String _selectedPlayerImagePath = '';
  BluetoothDevice?
      connectedDevice; // Nullable BluetoothDevice to manage connection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundImage(), // Updated background image
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: _buildAppBar(context),
          ),
          Positioned(
            top: 150,
            bottom: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildPlayerAvatar(), // Custom player avatar
                  Expanded(
                      child:
                          _buildPlayerList()), // Player list with updated design
                  _buildStartGameButton(context), // Updated start game button
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Image.asset(
      'assets/images/scbg.jpg', // Updated background image
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.greenAccent, Colors.lightBlue], // Updated colors
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Select Player',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.bluetooth, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BluetoothScanner(
                    onDeviceSelected: (BluetoothDevice device) {
                      setState(() {
                        connectedDevice = device;
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerAvatar() {
    return Column(
      children: [
        CircleAvatar(
          radius: 70,
          backgroundColor: Colors.greenAccent, // Updated color
          backgroundImage: AssetImage(
            _selectedPlayerImagePath.isNotEmpty
                ? _selectedPlayerImagePath
                : 'assets/images/avatar-image1.png', // Default avatar with eco-friendly theme
          ),
        ),
        const SizedBox(height: 10),
        Text(
          _selectedPlayerName.isNotEmpty
              ? _selectedPlayerName
              : 'Select Player',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerList() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _createPlayerTile(
              'Wilson Dokidis', 'assets/images/avatar-image2.png'),
          _createPlayerTile('Haylie Torff', 'assets/images/avatar-image3.png'),
          _createPlayerTile(
              'Wilson Dokidis', 'assets/images/avatar-image2.png'),
          _createPlayerTile('Haylie Torff', 'assets/images/avatar-image3.png'),
          _createPlayerTile(
              'Wilson Dokidis', 'assets/images/avatar-image2.png'),
          _createPlayerTile('Haylie Torff', 'assets/images/avatar-image3.png'),
          _createPlayerTile(
              'Wilson Dokidis', 'assets/images/avatar-image2.png'),
          _createPlayerTile('Haylie Torff', 'assets/images/avatar-image3.png'),
          _createPlayerTile(
              'Wilson Dokidis', 'assets/images/avatar-image2.png'),
          _createPlayerTile('Haylie Torff', 'assets/images/avatar-image3.png'),
          // More player tiles with eco-friendly avatars
        ],
      ),
    );
  }

  Widget _buildStartGameButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_selectedPlayerName.isNotEmpty && connectedDevice != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LevelScreen(
                connectedDevice: connectedDevice!,
                // playerName: _selectedPlayerName,
              ),
            ),
          );
        } else {
          String errorMsg = _selectedPlayerName.isEmpty
              ? 'Please select a player before starting the game.'
              : 'Bluetooth device not connected.';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green, // Updated start game button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          'Start Game',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  PlayerTile _createPlayerTile(String name, String imagePath) {
    return PlayerTile(
      name: name,
      imagePath: imagePath,
      onTap: () {
        setState(() {
          _selectedPlayerName = name;
          _selectedPlayerImagePath = imagePath;
        });
      },
    );
  }
}

class PlayerTile extends StatelessWidget {
  final String name;
  final String imagePath;
  final VoidCallback onTap;

  const PlayerTile({
    Key? key,
    required this.name,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white
          .withOpacity(0.7), // Updated card opacity for a lighter look
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.green, // Updated player tile color
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
