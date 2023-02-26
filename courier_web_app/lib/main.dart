import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'src/pages/camera_screen.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    CameraScreen.cameras = await availableCameras();
  } on CameraException catch (_) {
    CameraScreen.cameras = [];
  }

  runApp(const CourierBox());
}
