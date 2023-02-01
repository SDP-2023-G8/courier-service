import 'package:flutter/material.dart';

import '../data/routes.dart';
import 'qrScreen.dart';
import 'cameraScreen.dart';
import 'confirmScreen.dart';

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
        return MaterialPageRoute(builder: (_) => QRScreen(deliveryID));
      case cameraRoute:
        return MaterialPageRoute(builder: (_) => CameraScreen());
      case confirmRoute:
        return MaterialPageRoute(builder: (_) => ConfirmScreen("Something"));
      default:
        return MaterialPageRoute(
            builder: (_) =>
                Scaffold(body: Center(child: Text("404: Not Found"))));
    }
  }
}
