import 'package:flutter/material.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      children: [
        Text(
          "使いかた",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Text("1"),
          title: Text(
            "スマホ端末を'RaspberryPi_1'もしくは'RaspberryPi_2'のWi-Fiアクセスポイントに接続します。",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 14),
          ),
        ),
        ListTile(
          leading: Text("2"),
          title: Text(
            "AR画面に移動し、AR表示ボタンを押す",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 14),
          ),
        ),
        ListTile(
          leading: Text("3"),
          title: Text(
            "画面が切り替わり、カメラが起動したら、'add & remove'ボタンを押す",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 14),
          ),
        ),
        ListTile(
            leading: Text("4"),
            title: Text(
              "右上のファイル名をクリックすると描画するARオブジェクトをきりかえることができます",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 14),
            )),
      ],
    ));
  }
}
