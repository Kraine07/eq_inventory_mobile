

import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:equipment_inventory/Service/api_service.dart';
import 'package:equipment_inventory/messageHandler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService extends APIService{
  List<CameraDescription>? _cameras;
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  Uint8List? _capturedImageData;



Uint8List? get capturedImageData => _capturedImageData;

set capturedImageData(Uint8List? data){
  _capturedImageData = data;
  notifyListeners();
}





final ImagePicker picker = ImagePicker();

  Future<void> initializeCamera(BuildContext context) async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      MessageHandler.showMessage(context, message: "Camera permission denied", isSuccessMessage: false);
      return;
    }

    try {

      // Get a list of available cameras
      _cameras = await availableCameras();

      // use the first camera
      if (_cameras != null && _cameras!.isNotEmpty) {
        _cameraController = CameraController(_cameras![0], ResolutionPreset.medium);

        await _cameraController!.initialize();

         _isCameraInitialized = true;
      }
    }
    on CameraException catch (_) {
      MessageHandler.showMessage(context, message: "Error initializing camera.", isSuccessMessage: false);
      return;
    }
  }



  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _capturedImageData = await pickedFile.readAsBytes();
      notifyListeners();
    }

  }




  Future<void> captureImage(BuildContext context) async {
    if (!_isCameraInitialized || _cameraController == null) return;

    try {
      XFile _capturedImage = await _cameraController!.takePicture();
       _capturedImageData = await _capturedImage.readAsBytes();
      notifyListeners();

    }
    on CameraException catch (_) {
      MessageHandler.showMessage(context, message: "Error capturing image.", isSuccessMessage: false);
      return;

    }
  }


  void disposeCamera() async{
    await _cameraController?.dispose();
    _cameraController = null;
    _capturedImageData = null;
    _isCameraInitialized = false;
    notifyListeners();
  }




}

