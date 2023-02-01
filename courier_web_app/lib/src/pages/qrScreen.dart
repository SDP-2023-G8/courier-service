import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:qr_flutter/qr_flutter.dart';

const bool useEmulator = true;

class QRScreen extends StatefulWidget {
  final String title;
  final String url;

  const QRScreen(this.title, this.url);

  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  String _username = "";

  FirebaseFirestore db = FirebaseFirestore.instance;
  String host = 'localhost'; // change when using Cloud Firestore

  @override
  void didChangeDependencies() async {
    if (useEmulator) {
      db.useFirestoreEmulator(host, 8080);
      db.settings = const Settings(
        persistenceEnabled: true,
      );
    }

    await db.collection('users').doc('user1').get().then((user) {
      setState(() {
        if (user.exists) {
          this._username = user.data()!['username'];
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(widget.url),
      ),
    );
  }
}
