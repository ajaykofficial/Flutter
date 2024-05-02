import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WifiScanning extends StatefulWidget {
  const WifiScanning({Key? key}) : super(key: key);

  @override
  _WifiScanningState createState() => _WifiScanningState();
}

class _WifiScanningState extends State<WifiScanning> {
  bool _isLoading = false;
  String _response = '';
  String _ipAddress = '192.168.57.138'; // Default IP address

  final TextEditingController _ipAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ipAddressController.text = _ipAddress;
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.get(
        Uri.parse('http://$_ipAddress/data'),
      );
      log("this is the response: $response");

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        setState(() {
          _response = decodedData['message'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _response = 'Failed to fetch data';
          _isLoading = false;
        });
      }
    } catch (e) {
      log("Error fetching data: $e");
      setState(() {
        _response = 'Failed to fetch data';
        _isLoading = false;
      });
    }
  }

  // Other methods (sendMorseRequest, sendData) remain unchanged

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wifi Scanning',
          style: TextStyle(
            fontFamily: 'Norican-Regular',
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _ipAddressController,
              decoration: const InputDecoration(labelText: 'Enter IP Address'),
              onChanged: (value) {
                setState(() {
                  _ipAddress = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                fetchData();
              },
              child: const Text('Fetch Data'),
            ),
            // Other buttons and UI elements remain unchanged
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_response.isNotEmpty)
              Text(
                'Response: $_response',
                style: const TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}
