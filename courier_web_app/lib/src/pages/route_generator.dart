import 'package:flutter/material.dart';
import '../data/routes.dart';
import 'qr_screen.dart';
import 'camera_screen.dart';
import 'confirm_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    String? route;
    String? queryID;

    if (settings.name != null) {
      var uriData = Uri.parse(settings.name!); // Parse the URL
      route = uriData.path; // Get base URL
      queryID = uriData.queryParameters['id']; // Get query parameters
    }

    final String deliveryID = '$queryID';

    switch (route) {
      case homeRoute:
        return MaterialPageRoute(
            builder: (_) => QRScreen(deliveryID), settings: settings);
      case cameraRoute:
        return MaterialPageRoute(
            builder: (_) => const CameraScreen(), settings: settings);
      case confirmRoute:
        return MaterialPageRoute(
            builder: (_) => const ConfirmScreen(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) =>
                const Scaffold(body: Center(child: Text("404: Not Found"))),
            settings: settings);
    }
  }
}
