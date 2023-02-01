import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            SizedBox(
              height: 80,
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
