// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:location_based_ar/infrastructure/ar_object_download.dart';
import 'package:location_based_ar/view/ar_screen.dart';
import 'package:location_based_ar/view/no_communication_screen.dart';
import 'package:network_info_plus/network_info_plus.dart';

class ArDrawingButton extends StatelessWidget {
  const ArDrawingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      child: const Text("AR表示"),
      onPressed: () async {
        final info = NetworkInfo();
        final wifiName = await info.getWifiName();
        if (wifiName == null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NoCommunicationScreen()));
        } else if (wifiName == '"RaspberryPi_1"') {
          // await ArObjectDownload.downloadFile(
          //     'http://192.168.75.11:5000/get_glb', "1.glb");
          await ArObjectDownload.downloadAndExtractZip(
              'http://192.168.75.11:5000/get_glb');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArScreen(
                        fileNameList: ArObjectDownload.arFileList,
                      )));
          // } else if (wifiName == '"RaspberryPi_2"') {
          //   await ArObjectDownload.downloadFile(
          //       'http://192.168.75.12:5000/get_glb', "2.glb");
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => const LocalAndWebObjectsWidget(
          //                 fileName: "2.glb",
          //               )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NoCommunicationScreen()));
        }
      },
    ));
  }
}
