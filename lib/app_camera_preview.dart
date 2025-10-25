import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Service/camera_service.dart';

class AppCameraPreview extends StatefulWidget {
  const AppCameraPreview({super.key});

  @override
  State<AppCameraPreview> createState() => _AppCameraPreviewState();
}

class _AppCameraPreviewState extends State<AppCameraPreview> {
  bool _initializedOnce = false; // prevents reinitialization on rebuilds
  late CameraService _cameraService;





  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize the late field safely here
    if (!_initializedOnce) {
      _cameraService = Provider.of<CameraService>(context, listen: false);
      _initializedOnce = true;

      // Initialize camera after widget tree is ready
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!_cameraService.isCameraInitialized) {
          await _cameraService.initializeCamera(context);
        }
      });
    }
  }

  @override
  void dispose() {
    // Safe: _cameraService is already initialized
    _cameraService.disposeCamera();
    super.dispose();
  }


  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _cameraService = Provider.of<CameraService>(context, listen: false);
  // }
  //
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _cameraService.disposeCamera();
  //   // WidgetsBinding.instance.addPostFrameCallback((_) async {
  //   //   final cameraService = Provider.of<CameraService>(context, listen: false);
  //   //   if (!_initializedOnce && !cameraService.isCameraInitialized) {
  //   //     _initializedOnce = true;
  //   //     await cameraService.initializeCamera(context);
  //   //   }
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    final cameraService = Provider.of<CameraService>(context);

    if (!cameraService.isCameraInitialized ||
        cameraService.cameraController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Extract the controller once (avoid rebuild flicker)
    final controller = cameraService.cameraController!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: CameraPreview(controller),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () async {
                    await cameraService.captureImage(context);
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.camera, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   final cameraService = Provider.of<CameraService>(context, listen: false);
  //   cameraService.disposeCamera();
  //   super.dispose();
  // }
}
