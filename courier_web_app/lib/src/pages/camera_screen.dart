import 'package:courier_web_app/src/pages/confirm_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
  final List<CameraDescription> _cameras;
  late CameraController _controller;
  late Future<void> _initializedControllerFuture;

  @override
  void initState() {
    super.initState();
    resetCameraController();
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

  void resetCameraController() {
    _controller = CameraController(_cameras[0], ResolutionPreset.max);
    _initializedControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
          future: _initializedControllerFuture,
          builder: (context, snapshot) {
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
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(23)))),
                                    child: const Text(
                                      'Re-take Photo',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => callSetStateImage('')),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(23)))),
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      // TODO: upload image to database
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ConfirmScreen()),
                                      );
                                    })
                              ],
                            ),
                          )
                        : Expanded(
                            child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () async {
                              try {
                                await _initializedControllerFuture;
                                final image = await _controller.takePicture();

                                if (!mounted) return;

                                callSetStateImage(image.path);
                              } catch (e) {}
                            },
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
