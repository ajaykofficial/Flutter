import 'package:binbuddy/pages/bluetooth_scanner.dart';
import 'package:binbuddy/widgets/PlayerListWidgets/build_appbar.dart';
import 'package:binbuddy/widgets/PlayerListWidgets/build_backgroundimage.dart';
import 'package:binbuddy/widgets/PlayerListWidgets/build_playertile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';

class PlayerSelectionScreen extends StatefulWidget {
  const PlayerSelectionScreen({Key? key}) : super(key: key);

  @override
  _PlayerSelectionScreenState createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
  String _selectedPlayerName = '';
  String _selectedPlayerImagePath = '';

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<BluetoothDevicesModel>(context);
    final connectedDevice = model.connectedDevice;

    return Scaffold(
      body: Stack(
        children: [
          const BuildBackgroundImage(),
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: BuildAppBar(context: context),
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
                  _buildPlayerAvatar(),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              // image: const DecorationImage(
                              //     image: AssetImage('assets/images/scbg.jpg',)),
                              color: Colors.black.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(30)),
                          child: _buildPlayerList())),
                  _buildStartGameButton(context, connectedDevice),
                ],
              ),
            ),
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
          backgroundColor: Colors.blueGrey.withOpacity(0.7),
          backgroundImage: AssetImage(
            _selectedPlayerImagePath.isNotEmpty
                ? _selectedPlayerImagePath
                : 'assets/images/avatar-image1.png',
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white.withOpacity(0.7),
          ),
          child: Text(
            _selectedPlayerName.isNotEmpty
                ? _selectedPlayerName
                : 'Select Player',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget _buildPlayerList() {
    final players = [
      _createPlayerTile('Wilson Dokidis', 'assets/images/avatar-image2.png'),
      _createPlayerTile('Haylie Torff', 'assets/images/avatar-image3.png'),
      _createPlayerTile('Ethan James', 'assets/images/avatar-image1.png'),
      _createPlayerTile('James Oliver', 'assets/images/avatar-image4.png'),
      _createPlayerTile('Liam Alexander', 'assets/images/avatar-image7.png'),
      _createPlayerTile('Olivia Rose', 'assets/images/avatar-image6.png'),
      _createPlayerTile('Noah Benjamin', 'assets/images/avatar-image5.png'),
      _createPlayerTile('Sophia Marie', 'assets/images/avatar-image8.png'),
      _createPlayerTile('James Oliver', 'assets/images/avatar-image10.png'),
      _createPlayerTile('Ava Elizabeth', 'assets/images/avatar-image9.png'),
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: players,
      ),
    );
  }

  Widget _buildStartGameButton(
      BuildContext context, BluetoothDevice? connectedDevice) {
    return ElevatedButton(
      onPressed: () {
        if (_selectedPlayerName.isNotEmpty && connectedDevice != null) {
          Navigator.pushNamed(context, 'levelScreen');
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
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
      child: const Text(
        'Start Game',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _createPlayerTile(String name, String imagePath) {
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
