import 'package:flutter/material.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FractionallySizedBox(
              widthFactor: 0.8,
              child: FittedBox(
                  fit: BoxFit.cover,
                  child: Text(
                    '3. Delivery Complete! You can now close this tab',
                    style: TextStyle(fontSize: 22),
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
            Image.asset("assets/img/check.gif",
                height: 125.0, width: 125.0, fit: BoxFit.fitWidth)
            // VERIFIED GIF
          ],
        ),
      ),
    );
  }
}
