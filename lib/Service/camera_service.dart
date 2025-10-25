import 'dart:convert';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:equipment_inventory/Model/equipment_image.dart';
import 'package:equipment_inventory/Service/api_service.dart';
import 'package:equipment_inventory/messageHandler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraService extends APIService {
  List<CameraDescription>? _cameras;
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isInitializing = false; // NEW - prevents concurrent init
  bool _isCapturing = false; // NEW - prevents rapid captures
  Uint8List? _capturedImageData;

  Uint8List? get capturedImageData => _capturedImageData;
  CameraController? get cameraController => _cameraController;
  bool get isCameraInitialized => _isCameraInitialized;

  set capturedImageData(Uint8List? data) {
    _capturedImageData = data;
    notifyListeners();
  }

  final ImagePicker picker = ImagePicker();

  Future<void> initializeCamera(BuildContext context) async {
    // Prevent concurrent initializations
    if (_isInitializing) return;
    if (_isCameraInitialized && _cameraController?.value.isInitialized == true) {
      return; // already initialized
    }

    _isInitializing = true;

    final status = await Permission.camera.request();
    if (!status.isGranted) {
      MessageHandler.showMessage(
        context,
        message: "Camera permission denied",
        isSuccessMessage: false,
      );
      _isInitializing = false;
      return;
    }

    try {
      _cameras = await availableCameras();

      if (_cameras == null || _cameras!.isEmpty) {
        MessageHandler.showMessage(
          context,
          message: "No cameras found.",
          isSuccessMessage: false,
        );
        _isInitializing = false;
        return;
      }

      // Step 1: Get all back-facing cameras
      final backCameras = _cameras!
          .where((c) => c.lensDirection == CameraLensDirection.back)
          .toList();

      CameraDescription chosenCamera;

      if (backCameras.isEmpty) {
        // No back camera available — fallback to the first available
        chosenCamera = _cameras!.first;
      } else if (backCameras.length == 1) {
        // Only one back camera — use it
        chosenCamera = backCameras.first;
      } else {
        // Step 2: Try to find the "main" back camera by name
        CameraDescription? namePref;
        for (final c in backCameras) {
          final lower = c.name.toLowerCase();
          if (lower.contains('wide') ||
              lower.contains('main') ||
              lower.contains('back')) {
            namePref = c;
            break;
          }
        }

        if (namePref != null) {
          chosenCamera = namePref;
        } else {
          // Step 3: Probe back cameras and pick the one with largest preview size
          CameraDescription? bestCamera;
          int bestArea = 0;

          for (final cam in backCameras) {
            CameraController? tempController;
            try {
              // Use low resolution during probing to reduce buffer pressure
              tempController = CameraController(
                cam,
                ResolutionPreset.low,
                enableAudio: false,
              );
              await tempController.initialize();

              final size = tempController.value.previewSize;
              if (size != null) {
                final area = (size.width * size.height).toInt();
                if (area > bestArea) {
                  bestArea = area;
                  bestCamera = cam;
                }
              }
            } catch (_) {
              // ignore failures for this camera and continue
            } finally {
              try {
                if (tempController != null) {
                  // stop any image stream just in case, then dispose
                  try {
                    await tempController.stopImageStream();
                  } catch (_) {}
                  await tempController.dispose();
                }
              } catch (_) {}
              tempController = null;
            }
          }

          chosenCamera = bestCamera ?? backCameras.first;
        }
      }

      // If there's an existing controller, dispose it cleanly first
      if (_cameraController != null) {
        try {
          // stop streams and give the system a moment to release buffers
          try {
            await _cameraController?.stopImageStream();
          } catch (_) {}
          await _cameraController?.dispose();
        } catch (_) {}
        _cameraController = null;
        _isCameraInitialized = false;
      }

      // Step 4: Initialize the actual camera controller
      _cameraController = CameraController(
        chosenCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      _isCameraInitialized = true;
      notifyListeners();
    } on CameraException catch (e) {
      MessageHandler.showMessage(
        context,
        message: "Error initializing camera: ${e.code}",
        isSuccessMessage: false,
      );
    } catch (e) {
      MessageHandler.showMessage(
        context,
        message: "Unexpected error initializing camera.",
        isSuccessMessage: false,
      );
    } finally {
      _isInitializing = false;
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
    if (!_isCameraInitialized || _cameraController == null || _isCapturing) return;

    _isCapturing = true;

    // Show progress dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Optional: stop preview before capture (reduces buffer pressure)
      if (_cameraController!.value.isStreamingImages) {
        await _cameraController!.stopImageStream();
      }

      final XFile captured = await _cameraController!.takePicture();

      // Read bytes in a microtask to avoid blocking UI
      _capturedImageData = await captured.readAsBytes();
      notifyListeners();

      // Give Android a moment to release buffers
      await Future.delayed(const Duration(milliseconds: 150));
    } on CameraException catch (e) {
      MessageHandler.showMessage(
        context,
        message: "Error capturing image: ${e.description}",
        isSuccessMessage: false,
      );
    } finally {
      _isCapturing = false;

      // Close the progress dialog
      if (Navigator.canPop(context)) Navigator.pop(context);
    }
  }






  // Future<void> captureImage(BuildContext context) async {
  //   if (!_isCameraInitialized || _cameraController == null || _isCapturing) return;
  //
  //
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context){
  //         return Center(child: CircularProgressIndicator());
  //       }
  //   );
  //
  //   _isCapturing = true;
  //   try {
  //     XFile _capturedImage = await _cameraController!.takePicture();
  //     _capturedImageData = await _capturedImage.readAsBytes();
  //     notifyListeners();
  //   } on CameraException catch (_) {
  //     MessageHandler.showMessage(
  //         context, message: "Error capturing image.", isSuccessMessage: false);
  //     return;
  //   } finally {
  //     _isCapturing = false;
  //   }
  // }





  Future<void> disposeCamera() async {
    // Stop image stream and dispose the controller safely
    try {
      if (_cameraController != null) {
        try {
          await _cameraController!.stopImageStream();
        } catch (_) {}
        await _cameraController!.dispose();
      }
    } catch (_) {
      // ignore any dispose exceptions
    } finally {
      _cameraController = null;
      _capturedImageData = null;
      _isCameraInitialized = false;
    }
  }




  Future<EquipmentImage?> uploadImage(
      BigInt equipmentId, BuildContext context) async {
    if (_capturedImageData == null) return null;

    final response = await postMultipart(
      endpoint: "api/v1/save-equipment-image",
      fields: {"equipment": equipmentId.toString()},
      fileBytes: _capturedImageData!,
      fileFieldName: "equipment-image",
      // filename: "equipment_$equipmentId.jpg",
    );

    await CachedNetworkImage.evictFromCache("${baseURL}/api/v1/find-by-equipment?equipmentId=${equipmentId}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = await response.body;
      notifyListeners();
      MessageHandler.showMessage(
          context, message: "Image uploaded successfully");
      Navigator.pop(context);
      return EquipmentImage.fromJson(jsonDecode(responseBody));
    } else {
      MessageHandler.showMessage(
          context, message: "Error uploading image", isSuccessMessage: false);
      Navigator.pop(context);
      return null;
    }
  }


}
