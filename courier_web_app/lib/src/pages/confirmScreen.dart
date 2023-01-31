import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
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
