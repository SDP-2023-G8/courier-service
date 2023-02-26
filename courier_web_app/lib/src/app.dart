import 'package:flutter/material.dart';
import 'pages/route_generator.dart';

class CourierBox extends StatelessWidget {
  const CourierBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/?id=63f52275b2422530719ec323",
      title: 'InBoX Online Courier Service',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
