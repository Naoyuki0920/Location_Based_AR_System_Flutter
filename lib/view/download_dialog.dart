import 'package:flutter/material.dart';

class DownloadDialog {
  static void downloadDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Scaffold(
          appBar: AppBar(title: const Text("download")),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "ARデータ準備中",
                ),
                SizedBox(height: 20,),
                CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> loadingFLow(
    BuildContext context, {
    required Future<void> Function() function,
  }) async {
    downloadDialog(context);
    await function();
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
