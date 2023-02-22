import 'dart:convert';
import 'package:courier_web_app/src/pages/camera_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

const API_HOST =
    String.fromEnvironment('API_HOST', defaultValue: 'localhost:5000');

class QRScreen extends StatefulWidget {
  final String deliveryID;

  const QRScreen(this.deliveryID, {Key? key}) : super(key: key);

  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  @override
  void initState() {
    super.initState();

    // Subscribe to listen to scanned state of delivery
    subscribeScanned(deliveryId: widget.deliveryID).then((scanned) {
      if (scanned.isNotEmpty) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CameraScreen()));
      }
    });
  }

  // Make REST-API call to retrieve hash code for delivery
  Future<String> fetchHashCode({required String deliveryId}) async {
    final response = await http.get(
        Uri.parse("http://$API_HOST/api/v1/deliveries/$deliveryId"),
        headers: {'Access-Control-Allow-Origin': '*'});

    if (response.statusCode == 200) {
      // If server returns the delivery, parse JSON and return hashCode
      final parsedJson = jsonDecode(response.body);
      return parsedJson['hashCode'];
    } else {
      // If server does not return the delivery, raise exception
      throw Exception("Failed to retrieve the delivery");
    }
  }

  // Make REST-API call to subscribe to scanned flag state
  Future<String> subscribeScanned({required String deliveryId}) async {
    final response = await http
        .get(Uri.parse("http://$API_HOST/api/v1/deliveries/$deliveryId/poll"));

    if (response.statusCode == 201) {
      // If the scanned value of the delivery is changed, server will reply
      // with status code 201
      return response.body;
    } else {
      throw Exception("Failed to subscribe to the delivery");
    }
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
              future: fetchHashCode(deliveryId: widget.deliveryID),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
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
