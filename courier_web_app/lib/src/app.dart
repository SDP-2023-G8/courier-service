import 'package:flutter/material.dart';
import 'pages/qrScreen.dart';

class CourierBox extends StatelessWidget {
  const CourierBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'InBoX Online Courier Service',
      home: QRScreen(),
    );
  }
}
