import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;

class ArObjectDownload {
  static HttpClient httpClient = HttpClient();
  static List<String> arFileList = [];

  static Future<void> downloadAndExtractZip(url) async {
    var response = await http.get(Uri.parse(url));
    var tempDir = await getTemporaryDirectory();
    var tempPath = tempDir.path;
    File zipFile = File('$tempPath/file.zip');
    await zipFile.writeAsBytes(response.bodyBytes);
    final bytes = File(zipFile.path).readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);
    String dir = (await getApplicationDocumentsDirectory()).path;
    arFileList.clear();
    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final data = file.content as List<int>;
        File('$dir/$filename')
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      }
      arFileList.add(filename);
    }
  }
}
