import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// keyを用意
const raspi1Key = 'name';
const raspi2Key = 'comment';
const iconKey = 'icon';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static String raspi1 = '192.168.186.11';
  static String raspi2 = '192.168.186.12';
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final raspi1Controller = TextEditingController();
  final raspi2Controller = TextEditingController();
  bool icon = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  // アプリ起動時に保存したデータを読み込む
  void init() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      SettingScreen.raspi1 = prefs.getString(raspi1Key)!;
      SettingScreen.raspi2 = prefs.getString(raspi2Key)!;
      icon = prefs.getBool(iconKey)!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListTile(
              // 保存された場合のデータを表示する
              leading: icon == false
                  ? const Icon(Icons.chat_bubble_outline)
                  : const Icon(Icons.chat),
              tileColor: Colors.white24,
              title: Text(SettingScreen.raspi1),
              subtitle: const Text("RaspberryPi_1"),
            ),
            ListTile(
              // 保存された場合のデータを表示する
              leading: icon == false
                  ? const Icon(Icons.chat_bubble_outline)
                  : const Icon(Icons.chat),
              tileColor: Colors.white24,
              title: Text(SettingScreen.raspi2),
              subtitle: const Text("RaspberryPi_2"),
            ),
            TextField(
              controller: raspi1Controller,
              decoration:
                  const InputDecoration(hintText: 'RaspberryPi_1のIPアドレスを入力'),
            ),
            TextField(
              controller: raspi2Controller,
              decoration:
                  const InputDecoration(hintText: 'RaspberryPi_2のIPアドレスを入力'),
            ),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                // データを保存する
                prefs.setString(raspi1Key, raspi1Controller.text);
                prefs.setString(raspi2Key, raspi2Controller.text);
                prefs.setBool(iconKey, true);
                setState(() {
                  // データを読み込む
                  SettingScreen.raspi1 = prefs.getString(raspi1Key)!;
                  SettingScreen.raspi2 = prefs.getString(raspi2Key)!;
                  prefs.setBool(iconKey, true);
                  if (SettingScreen.raspi1 != '' &&
                      SettingScreen.raspi2 != '') {
                    icon = true;
                  }
                });
              },
              child: const Text('Save'),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     final prefs = await SharedPreferences.getInstance();
            //     setState(() {
            //       // データを削除する
            //       icon = false;
            //       title = '';
            //       titleController.text = '';
            //       comment = '';
            //       commentController.text = '';
            //       prefs.remove(titleKey);
            //       prefs.remove(commentKey);
            //     });
            //   },
            //   child: const Text('Clear'),
            // ),
          ],
        ),
      ),
    );
  }
}
