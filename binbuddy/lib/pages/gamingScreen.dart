import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:lottie/lottie.dart';

class GamingScreen extends StatefulWidget {
  final int level;
  final BluetoothDevice connectedDevice;

  const GamingScreen({
    Key? key,
    required this.level,
    required this.connectedDevice,
  }) : super(key: key);

  @override
  _GamingScreenState createState() => _GamingScreenState();
}

class _GamingScreenState extends State<GamingScreen> {
  BluetoothCharacteristic? notificationCharacteristic;
  int droppedWasteCount = 0;

  final List<Map<String, String>> wasteImages = [
    {"path": "assets/images/apple_waste.png", "category": "biowaste"},
    {"path": "assets/images/ewaste_computer.png", "category": "ewaste"},
    {
      "path": "assets/images/plastic_bottle_waste.png",
      "category": "plasticwaste",
    },
  ];

  final List<Map<String, String>> binImages = [
    {"path": "assets/images/reader_biowaste_bin.png", "category": "biowaste"},
    {"path": "assets/images/reader_ewaste_bin.png", "category": "ewaste"},
    {
      "path": "assets/images/reader_plasticwaste_bin.png",
      "category": "plasticwaste",
    },
  ];

  @override
  void initState() {
    super.initState();
    _discoverServices();
  }

  Future<void> _discoverServices() async {
    try {
      final services = await widget.connectedDevice.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString() ==
              "beb5483e-36e1-4688-b7f5-ea07361b26a8") {
            notificationCharacteristic = characteristic;

            // Enable notifications to receive data from the ESP32
            await notificationCharacteristic!.setNotifyValue(true);

            // Handle incoming data and show appropriate dialogs
            notificationCharacteristic!.lastValueStream.listen((data) {
              final message = String.fromCharCodes(data);
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
    if (message.contains("Correctly sorted")) {
      _showCorrectDialog(context);
    } else if (message.contains("Incorrectly sorted")) {
      _showWrongDialog(context);
    } else {
      print("Unexpected message: $message");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> levelWasteImages =
        wasteImages.take(widget.level).toList();

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
    BuildContext context,
    List<Map<String, String>> wasteImages,
  ) {
    List<Widget> widgets = [];
    final random = Random();
    List<Rect> occupiedRects = [];

    for (var image in wasteImages) {
      double left = 0.0, top = 0.0;
      bool isOverlapping = true;

      while (isOverlapping) {
        left = random.nextDouble() * (MediaQuery.of(context).size.width - 130);
        top = random.nextDouble() * (MediaQuery.of(context).size.height - 130);

        Rect newRect = Rect.fromLTWH(left, top, 130, 130);
        bool isColliding = false;
        for (Rect rect in occupiedRects) {
          if (newRect.overlaps(rect)) {
            isColliding = true;
            break;
          }
        }

        if (!isColliding) {
          isOverlapping = false;
        }
      }

      occupiedRects.add(Rect.fromLTWH(left, top, 130, 130));
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
            _showCorrectDialog(context);
          } else {
            _showWrongDialog(context);
          }
        },
        builder: (context, candidateData, rejectedData) {
          return Image.asset(
            image["path"]!,
            width: 125,
            height: 125,
          );
        },
      );
    }).toList();
  }

  void _showCorrectDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                'Correctly sorted!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showWrongDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                'Incorrectly sorted!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAllWasteDroppedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
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
                  color: Colors.green,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }
}
