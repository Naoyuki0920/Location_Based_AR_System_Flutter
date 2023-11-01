import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';
import 'package:http/http.dart' as http;

class ArObjectDownload {
  static HttpClient httpClient = HttpClient();
  static List<String> arFileList = [];

  static Future<void> downloadAndExtractZip(url) async {
    // ZIPファイルをダウンロード
    var response = await http.get(Uri.parse(url));

    // ZIPファイルを保存する一時的なディレクトリを取得
    var tempDir = await getTemporaryDirectory();
    var tempPath = tempDir.path;

    // ZIPファイルを一時的なディレクトリに保存
    File zipFile = File('$tempPath/file.zip');
    await zipFile.writeAsBytes(response.bodyBytes);

    // ZIPファイルを解凍
    final bytes = File(zipFile.path).readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);

    // zip内のファイルの展開先を指定
    String dir = (await getApplicationDocumentsDirectory()).path;

    // ZIPファイル内のファイルを一時的なディレクトリに展開
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
      print(arFileList);
      print(filename);
    }

    print('ZIPファイルが解凍されました。');
  }
}
