import 'package:flutter/material.dart';

import 'pages/qrScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InBoX QR Code',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QRScreen('1. Please scan the QR code below:'),
    );
  }
}
