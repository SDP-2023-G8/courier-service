import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:courier_web_app/src/pages/confirm_screen.dart';

const bool useEmulator = false;

class CameraScreen extends StatefulWidget {
  static late List<CameraDescription> cameras;

  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreen createState() => _CameraScreen(cameras);
}

class _CameraScreen extends State<CameraScreen> {
  _CameraScreen(this._cameras);

  bool _flag = false;
  late String _imagePath;
  late Reference storageRef;
  final List<CameraDescription> _cameras;
  late CameraController _controller;
  late Future<void> _initializedControllerFuture;

  @override
  void initState() {
    imageCache!.clear();
    imageCache!.clearLiveImages();
    super.initState();
    resetCameraController();
    String host = 'localhost';

    // Create Firebase Storage reference
    final FirebaseStorage storageInstance = FirebaseStorage.instance;

    if (useEmulator) {
      storageInstance.useStorageEmulator(host, 9199);
    }

    storageRef = storageInstance.ref().child('file.jpg');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void callSetStateImage(String imagePath) {
    setState(() {
      resetCameraController();
      _imagePath = imagePath;
      _flag = !_flag;
    });
  }

  void uploadImage(String imagePath) async {
    try {
      // Convert BLOB image url to string of bytes for upload
      Uint8List fileBytes = await http.readBytes(Uri.parse(imagePath));
      await storageRef.putData(fileBytes);
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  void resetCameraController() {
    CameraDescription description = _cameras.isEmpty
        ? const CameraDescription(
            name: '',
            lensDirection: CameraLensDirection.back,
            sensorOrientation: 1)
        : _cameras[1];
    _controller =
        CameraController(description, ResolutionPreset.max, enableAudio: false);
    _initializedControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
          future: _initializedControllerFuture,
          builder: (context, snapshot) {
            if (_cameras.isEmpty) return const ConfirmScreen();
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Expanded(
                      child: Text(
                        '2. (Optional) Take Photo Evidence of Delivery',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: _flag
                          ? Image.network(_imagePath)
                          : CameraPreview(_controller),
                    ),
                    _flag
                        ? Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                        minimumSize: Size(
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                50,
                                            50),
                                        backgroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 15.0)),
                                    child: const Text(
                                      'Retake',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => callSetStateImage('')),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width /
                                                  2 -
                                              50,
                                          50),
                                      backgroundColor: const Color(0xff7fb069),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 15.0),
                                    ),
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      uploadImage(_imagePath);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ConfirmScreen()),
                                      );
                                    }),
                              ],
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                const Spacer(),
                                Expanded(
                                    child: FloatingActionButton(
                                  backgroundColor: Colors.black,
                                  onPressed: () async {
                                    try {
                                      await _initializedControllerFuture;
                                      final image =
                                          await _controller.takePicture();

                                      if (!mounted) return;

                                      callSetStateImage(image.path);
                                    } catch (_) {}
                                  },
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                )),
                                Expanded(
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                color: Color(0xff7fb069)),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15.0)),
                                        child: const Text(
                                          'Skip >',
                                          style: TextStyle(
                                              color: Color(0xff7fb069),
                                              fontSize: 20),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ConfirmScreen()),
                                          );
                                        }))
                              ],
                            ),
                          )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
