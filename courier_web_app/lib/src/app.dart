import 'package:flutter/material.dart';
import 'pages/qrScreen.dart';

class CourierBox extends StatelessWidget {
  const CourierBox(this.cameras);

  final cameras;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InBoX Online Courier Service',
      home: QRScreen(cameras),
    );
  }
}
