import 'dart:math';
import 'package:binbuddy/pages/player_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';

late int level;

class GamingScreen extends StatefulWidget {
  const GamingScreen({
    Key? key,
  }) : super(key: key);

  @override
  _GamingScreenState createState() => _GamingScreenState();
}

class _GamingScreenState extends State<GamingScreen> {
  BluetoothCharacteristic? notificationCharacteristic;
  int droppedWasteCount = 0;
  int tagsRead = 0; // To track the number of tags read
  int correctlySortedCount = 0;
  int incorrectlySortedCount = 0;
  int levelCount = 0;
  String lastTag = '';
  bool _flag = true;
  BuildContext?
      _dialogContext; // Variable to keep track of the current dialog context

  late final AudioPlayer _audioPlayer;

  final List<Map<String, String>> wasteImages = [
    {"path": "assets/images/apple_waste.png", "category": "biowaste"},
    {"path": "assets/images/ewaste_computer.png", "category": "ewaste"},
    {
      "path": "assets/images/plastic_bottle_waste.png",
      "category": "plasticwaste",
    },
    {"path": "assets/images/apple_waste.png", "category": "biowaste"},
    {"path": "assets/images/ewaste_computer.png", "category": "ewaste"},
    {
      "path": "assets/images/plastic_bottle_waste.png",
      "category": "plasticwaste",
    },
    {"path": "assets/images/apple_waste.png", "category": "biowaste"},
    {"path": "assets/images/ewaste_computer.png", "category": "ewaste"},
    {
      "path": "assets/images/plastic_bottle_waste.png",
      "category": "plasticwaste",
    },
  ];

  final List<Map<String, String>> binImages = [
    {"path": "assets/images/reader_biowaste_bin.png", "category": "biowaste"},
    // {"path": "assets/images/reader_ewaste_bin.png", "category": "ewaste"},
    {
      "path": "assets/images/reader_plasticwaste_bin.png",
      "category": "plasticwaste",
    },
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _discoverServices(); // Discover Bluetooth services
  }

  Future<void> _discoverServices() async {
    try {
      final connectedDevice = FlutterBluePlus.connectedDevices.first;
      final services = await connectedDevice.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString() ==
              "beb5483e-36e1-4688-b7f5-ea07361b26a8") {
            notificationCharacteristic = characteristic;

            // Enable notifications to receive data from the ESP32
            await notificationCharacteristic!.setNotifyValue(true);

            // Handle incoming data
            notificationCharacteristic!.lastValueStream.listen((data) {
              String message = "";
              message = String.fromCharCodes(data);
              _handleReceivedData(message);
            });
          }
        }
      }
    } catch (e) {
      print("Error discovering services: $e");
    }
  }

  void _handleReceivedData(String message) {
    if (message.isEmpty) {
      print("Received empty message");
      return;
    }

    final id = message.split(',')[0];
    if (id != lastTag) {
      lastTag = id;
    } else if (id == lastTag) {
      return;
    }
    if (_flag) {
      if (message.contains("Correctly sorted")) {
        _showCorrectDialog(context); // Show correct sorting dialog
        correctlySortedCount++;
        print(message);
        tagsRead++;
      } else if (message.contains("Incorrectly sorted")) {
        _showWrongDialog(context); // Show incorrect sorting dialog
        incorrectlySortedCount++;
        tagsRead++;
      }
      // print(
      // "$tagsRead............................"); // Increment tagsRead for every valid sorting attempt
      if (tagsRead == level) {
        setState(() {
          _flag = false;
        });
        // Show level completion dialog when all tags are read
        _showAllWasteDroppedDialog(context);
        levelCount = level;
      }
    }
  }

  @override
  void dispose() {
    if (notificationCharacteristic != null) {
      notificationCharacteristic!.setNotifyValue(false); // Stop notifications
    }
    _audioPlayer.dispose(); // Release audio resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String levels = ModalRoute.of(context)!.settings.arguments.toString();
    level = int.parse(levels);

    List<Map<String, String>> levelWasteImages =
        wasteImages.take(level).toList();

    return Scaffold(
      backgroundColor: Colors.greenAccent.withOpacity(0.5),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/scbg.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          ..._buildRandomWasteImages(context, levelWasteImages),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildBinImages(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRandomWasteImages(
      BuildContext context, List<Map<String, String>> wasteImages) {
    List<Widget> widgets = [];
    final random = Random();
    List<Rect> occupiedRects = [];

    for (var image in wasteImages) {
      double left =
          random.nextDouble() * (MediaQuery.of(context).size.width - 130);
      double top =
          random.nextDouble() * (MediaQuery.of(context).size.height - 130);

      // Ensure no overlap between images
      bool isOverlapping = true;
      while (isOverlapping) {
        Rect newRect = Rect.fromLTWH(left, top, 130, 130);
        isOverlapping = occupiedRects.any((rect) => rect.overlaps(newRect));

        if (isOverlapping) {
          left =
              random.nextDouble() * (MediaQuery.of(context).size.width - 130);
          top =
              random.nextDouble() * (MediaQuery.of(context).size.height - 130);
        } else {
          occupiedRects.add(newRect);
        }
      }

      widgets.add(
        Positioned(
          left: left,
          top: top,
          child: Draggable(
            data: image["category"],
            feedback: Image.asset(
              image["path"]!,
              width: 130,
              height: 130,
              fit: BoxFit.cover,
            ),
            childWhenDragging: Container(),
            child: Image.asset(
              image["path"]!,
              width: 130,
              height: 130,
            ),
            onDragCompleted: () {
              setState(() {
                droppedWasteCount++;
                if (droppedWasteCount == wasteImages.length) {
                  _showAllWasteDroppedDialog(context);
                }
              });
            },
          ),
        ),
      );
    }

    return widgets;
  }

  List<Widget> _buildBinImages(BuildContext context) {
    return binImages.map((image) {
      return DragTarget(
        onAccept: (data) {
          if (data == image["category"]) {
            _showCorrectDialog(context); // Show correct sorting dialog
          } else {
            _showWrongDialog(context); // Show incorrect sorting dialog
          }
        },
        builder: (context, candidateData, rejectedData) {
          return Image.asset(
            image["path"]!,
            width: 180,
            height: 180,
          );
        },
      );
    }).toList();
  }

  void _showCorrectDialog(BuildContext context) {
    _dismissCurrentDialog(); // Dismiss current dialog if any
    _audioPlayer
        .setAsset('assets/audios/congratulations_malayalam.mp3')
        .then((_) {
      _audioPlayer.play(); // Play correct sound
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        _dialogContext = context; // Save the context of the current dialog
        return AlertDialog(
          backgroundColor: Colors.lightGreenAccent,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/gif/success.gif',
                height: 200,
                width: 200,
              ),
              const Text(
                'Well Done🤩!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _dialogContext =
                      null; // Reset the context after dismissing the dialog
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showWrongDialog(BuildContext context) {
    _dismissCurrentDialog(); // Dismiss current dialog if any
    _audioPlayer.setAsset('assets/audios/try_again_malayalam.mp3').then((_) {
      _audioPlayer.play(); // Play incorrect sound
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        _dialogContext = context; // Save the context of the current dialog
        return AlertDialog(
          backgroundColor: Colors.redAccent,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/gif/incorrect.gif',
                height: 200,
                width: 200,
              ),
              const Text(
                'Try Again😊',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _dialogContext =
                      null; // Reset the context after dismissing the dialog
                },
                child: const Text("OK"),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAllWasteDroppedDialog(BuildContext context) {
    _dismissCurrentDialog(); // Dismiss current dialog if any
    _audioPlayer
        .setAsset('assets/audios/level_complete_malayalam.mp3')
        .then((_) {
      _audioPlayer.play(); // Play level completion sound
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        _dialogContext = context; // Save the context of the current dialog
        return AlertDialog(
          backgroundColor: Colors.lightBlueAccent,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/animations/celebration_animation.json',
                height: 200,
                width: 200,
              ),
              const Text(
                'Level Complete!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  lastTag = "";
                  // Navigator.popAndPushNamed(context, 'playerList');
                  Navigator.pushAndRemoveUntil<void>(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const PlayerSelectionScreen()),
                    ModalRoute.withName('playerList'),
                  );
                  _dialogContext =
                      null; // Reset the context after dismissing the dialog
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }

// Method to dismiss the current dialog if any
  void _dismissCurrentDialog() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop();
      _dialogContext = null;
    }
  }
}
