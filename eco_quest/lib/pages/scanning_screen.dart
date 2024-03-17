import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter/services.dart'; // For platform channels

class ScanningScreen extends StatefulWidget {
  const ScanningScreen({Key? key}) : super(key: key);

  @override
  _ScanningScreenState createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  bool _isScanning = false;
  final FlutterBluePlus flutterBluePlus = FlutterBluePlus();
  List<ScanResult> _discoveredDevices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Scanning Screen',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: Colors.amberAccent,
        elevation: 0,
      ),
      body: Stack(children: [
        Image.asset(
          'assets/images/kid_bg.jpg',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _toggleScanning,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isScanning ? Colors.redAccent : Colors.lightGreenAccent,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  _isScanning ? 'Stop Scanning' : 'Start Scanning',
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _discoveredDevices.length,
                  itemBuilder: (context, index) {
                    final device = _discoveredDevices[index].device;
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(
                          device.name.isNotEmpty
                              ? device.name
                              : 'Unknown Device',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(device.id.toString()),
                        trailing: Icon(Icons.bluetooth),
                        onTap: () {
                          _connectToDevice(device);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void _toggleScanning() async {
    bool isBluetoothOn = await _checkBluetoothStatus();
    if (!isBluetoothOn) {
      // Handle Bluetooth off case
      return;
    }

    setState(() {
      _isScanning = !_isScanning;
    });

    if (_isScanning) {
      _startScanning();
    } else {
      _stopScanning();
    }
  }

  Future<bool> _checkBluetoothStatus() async {
    try {
      final bool? isBluetoothOn =
          await const MethodChannel("com.example.eco_quest/bluetooth")
              .invokeMethod<bool>('checkBluetoothStatus');
      return isBluetoothOn ?? false;
    } on PlatformException catch (e) {
      print('Error: ${e.message}');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'Failed to check Bluetooth status. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return false;
    }
  }

  void _startScanning() {
    _discoveredDevices.clear();

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((List<ScanResult> scanResults) {
      setState(() {
        _discoveredDevices = scanResults;
      });
    });

    Future.delayed(const Duration(seconds: 5), () {
      FlutterBluePlus.stopScan();
      setState(() {
        _isScanning = false;
      });
    });
  }

  void _stopScanning() {
    FlutterBluePlus.stopScan();
    setState(() {
      _isScanning = false;
    });
  }

  void _connectToDevice(BluetoothDevice device) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            bool isDisconnecting = false; // Flag to track disconnecting state
            return AlertDialog(
              title: Text('Connecting to ${device.name}...'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
              actions: [
                if (!isDisconnecting)
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _disconnectFromDevice(device);
                    },
                    child: Text('Disconnect'),
                  ),
              ],
            );
          },
        );
      },
    );

    device.connect().then((_) {
      Navigator.pop(context);
      print('Connected to ${device.name}');
    }).catchError((error) {
      Navigator.pop(context);
      print('Error connecting to ${device.name}: $error');
    });
  }

  void _disconnectFromDevice(BluetoothDevice device) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Disconnecting from ${device.name}...'),
          content: const CircularProgressIndicator(),
        );
      },
    );

    device.disconnect().then((_) {
      Navigator.pop(context);
      print('Disconnected from ${device.name}');
    }).catchError((error) {
      Navigator.pop(context);
      print('Error disconnecting from ${device.name}: $error');
    });
  }
}
