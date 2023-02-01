import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courier_web_app/src/pages/cameraScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';

const bool useEmulator = true;

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  String _username = "";

  FirebaseFirestore db = FirebaseFirestore.instance;
  String host = 'localhost'; // change when using Cloud Firestore

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (useEmulator) {
      db.useFirestoreEmulator(host, 8080);
      db.settings = const Settings(
        persistenceEnabled: true,
      );
    }

    await db.collection('users').doc('user1').get().then((user) {
      setState(() {
        if (user.exists) {
          _username = user.data()!['username'];
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '1. Point the QR Code at the Camera',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 50,
            ),
            QrImage(data: 'deliveryID+hashCode', size: 300),
            TextButton(
              child: const Text(
                'Next (debugging)',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Colors.orange,
                  letterSpacing: -0.5,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CameraScreen()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
