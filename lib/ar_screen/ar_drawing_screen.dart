import 'package:flutter/material.dart';
import 'package:location_based_ar/ar_screen/ar_drawing_button.dart';
import 'package:network_info_plus/network_info_plus.dart';

class ArDrawingScreen extends StatefulWidget {
  const ArDrawingScreen({super.key});

  @override
  State<ArDrawingScreen> createState() => _ArDrawingScreenState();
}

class _ArDrawingScreenState extends State<ArDrawingScreen> {
  late var info;
  late Future<String?> wifiName;

  @override
  void initState() {
    super.initState();
    info = NetworkInfo();
    wifiName = getInfo();
  }

  Future<String?> getInfo() async {
    return await info.getWifiName();
  }

  Future<void> _refresh() async {
    setState(() {
      wifiName = getInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RefreshIndicator(
            onRefresh: _refresh,
            child: FutureBuilder<String?>(
              future: wifiName,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  String? data = snapshot.data;
                  return Text("SSID: $data");
                } else {
                  return const Text('No Data');
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          const ArDrawingButton(),
        ],
      ),
    );
  }
}
