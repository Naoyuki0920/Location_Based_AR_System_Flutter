import 'package:flutter/material.dart';

class NoCommunicationScreen extends StatelessWidget {
  const NoCommunicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(child: Text("ラズパイのアクセスポイントに接続していません")),
    );
  }
}
