import 'package:courier_web_app/src/data/database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:courier_web_app/src/pages/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:js' as js;

const bool useEmulator = false;

class QRScreen extends StatefulWidget {
  final String deliveryID;

  const QRScreen(this.deliveryID, {Key? key}) : super(key: key);

  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  FirebaseDatabase db = FirebaseDatabase.instance;
  String host = 'localhost'; // change when using Firebase

  @override
  void initState() {
    super.initState();

    if (useEmulator) {
      db.useDatabaseEmulator(host, 9000);
    }

    // Set up database listener
    DatabaseReference scannedRef =
        db.ref('deliveries/${widget.deliveryID}/scanned');
    scannedRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value; // updated scanned value
      if (data == true) {
        js.context.callMethod('triggerVibrate');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CameraScreen()));
      }
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
          FutureBuilder(
              future: RealtimeDatabase.read(deliveryId: widget.deliveryID),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return QrImage(
                      data: '${widget.deliveryID}+${snapshot.data.toString()}',
                      size: 270);
                } else {
                  return const CircularProgressIndicator();
                }
              })
        ],
      ),
    ));
  }
}
