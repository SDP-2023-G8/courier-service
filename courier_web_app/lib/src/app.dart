import 'package:flutter/material.dart';

import 'pages/qrScreen.dart';

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

    return MaterialPageRoute(
      builder: (context) {
        return QRScreen("1. Please scan the QR code below:", deliveryID);
      },
      settings: settings,
    );
  }
}

class CourierBox extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/?id=245",
      title: 'InBoX Online Courier Service',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) {
          return QRScreen("Home", "NaN");
        }
      },
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
