import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen(this.cameras, this.flag);

  final List<CameraDescription> cameras;
  final bool flag;

  @override
  _CameraScreen createState() => _CameraScreen(cameras, flag);
}

class _CameraScreen extends State<CameraScreen> {
  _CameraScreen(this._cameras, this._flag);

  bool _flag;
  late String _imagePath;
  final List<CameraDescription> _cameras;
  late CameraController _controller;
  late Future<void> _initializedControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(_cameras[0], ResolutionPreset.max);
    _initializedControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void callSetStateImage(String imagePath) {
    setState(() {
      _imagePath = imagePath;
      _flag = true;
    });
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
              padding: const EdgeInsets.fromLTRB(10, 25, 10, 10),
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
                    Expanded(
                        child: FloatingActionButton(
                      onPressed: () async {
                        try {
                          await _initializedControllerFuture;
                          final image = await _controller.takePicture();

                          if (!mounted) return;
                          callSetStateImage(image.path);
                          // await Navigator.of(context).push(
                          //   MaterialPageRoute(builder: (context) {
                          //     _imagePath = image.path;
                          //     return CameraScreen(_cameras, true);
                          //   }),
                          // );
                        } catch (e) {}
                      },
                      child: const Icon(Icons.camera_alt),
                    ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
