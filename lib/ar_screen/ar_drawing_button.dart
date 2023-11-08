// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:location_based_ar/infrastructure/ar_object_download.dart';
import 'package:location_based_ar/ar_screen/ar_screen.dart';
import 'package:location_based_ar/ar_screen/download_dialog.dart';
import 'package:location_based_ar/ar_screen/no_communication_screen.dart';
import 'package:location_based_ar/setteing_screen/setting_screen.dart';
import 'package:network_info_plus/network_info_plus.dart';

class ArDrawingButton extends StatelessWidget {
  const ArDrawingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () async {
        final info = NetworkInfo();
        final wifiName = await info.getWifiName();
        if (wifiName == null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NoCommunicationScreen()));
        } else if (wifiName == '"RaspberryPi_1"') {
          screenChange(context, "http://${SettingScreen.raspi1}:5000/get_glb");
        } else if (wifiName == '"RaspberryPi_2"') {
          screenChange(context, "http://${SettingScreen.raspi2}:5000/get_glb");
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NoCommunicationScreen()));
        }
      },
      child: const Text("AR表示"),
    ));
  }

  void screenChange(context, url) async {
    await DownloadDialog.loadingFLow(
      context,
      function: () async {
        await ArObjectDownload.downloadAndExtractZip(url);
      },
    );
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ArScreen(
                  fileNameList: ArObjectDownload.arFileList,
                )));
  }
}
