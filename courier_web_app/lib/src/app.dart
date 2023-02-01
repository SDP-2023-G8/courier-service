import 'package:flutter/material.dart';

import 'pages/qrScreen.dart';

class CourierBox extends StatelessWidget {
  const CourierBox();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InBoX Online Courier Service',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QRScreen('1. Please scan the QR code below:'),
    );
  }
}
