import 'dart:io';
import 'dart:typed_data';


import 'package:equipment_inventory/Components/button.dart';
import 'package:equipment_inventory/Components/icon.dart';
import 'package:equipment_inventory/app_camera_preview.dart';
import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

import 'Service/camera_service.dart';

class EquipmentImagePage extends StatefulWidget {
  final BigInt? equipmentId;
  final Widget? image;
  const EquipmentImagePage({super.key, required this.image, required this.equipmentId});

  @override
  State<EquipmentImagePage> createState() => _EquipmentImagePageState();
}




class _EquipmentImagePageState extends State<EquipmentImagePage> {

  late CameraService _cameraService;



  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cameraService = Provider.of<CameraService>(context, listen: false);
  }


  @override
  void dispose() {

    _cameraService.disposeCamera();

    super.dispose();
  }


  //image picker
  final ImagePicker picker = ImagePicker();



  // pick image method
  void pickImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      await Provider.of<CameraService>(context, listen: false).captureImage(context);
    }
    else{
     await Provider.of<CameraService>(context, listen: false).pickImage();
    }
  }




  @override
  Widget build(BuildContext context) {

    Uint8List? pickedImageData = context.watch<CameraService>().capturedImageData;


    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            
                // upload image button
                Visibility(
                  visible: Provider.of<CameraService>(context, listen: false).capturedImageData != null,
                  child: IconButton(
                    onPressed: (){
                      Provider.of<CameraService>(context, listen: false).uploadImage(widget.equipmentId!, context);
                    },
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 8,
                      children: [
                        Icon(Icons.upload),
                        Text("Upload Image",
                          style: TextStyle(
                              fontSize: 16
                          ),
                        )
                      ],
                    ),
                    iconSize: 40,
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.all(12),
                      backgroundColor: AppColors.appDarkBlue40,
                      foregroundColor: AppColors.appWhite,
                    ),
            
                  ),
                ),
            
            
            
                // image preview
                InteractiveViewer(
                  maxScale: 3,
                  minScale: 1,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.7
                    ),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: pickedImageData != null? Image.memory(
                        pickedImageData,
                      fit: BoxFit.contain,
                    ) : widget.image,

                  ),
                ),
            
                InkWell(
                  onTap: (){
            
            
                    showModalBottomSheet(context: context, builder: (context){
                      return Container(
                        height: 200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
            
                            // capture image button
                            InkWell(
                              onTap: ()async {
                                await Navigator.push(context, MaterialPageRoute(builder: (context)=>AppCameraPreview()));
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppIcon(icon: Symbols.photo_camera, weight: 200, size: 60,),
                                    Text("Take Photo"),
                                  ],
                                ),
                              ),
                            ),
            
            
                            // gallery button
                            InkWell(
                              onTap: (){
                                pickImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppIcon(icon: Symbols.photo_library, weight: 200, size: 60,),
                                    Text("Choose from Gallery"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
            
                      );
                    });
                  },
            
            
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: AppColors.appDarkBlue40,
                    ),
                      child: AppIcon(icon: Symbols.change_circle, weight: 300, size: 40,)
                  ),
                ),
            
            
            
            
            
              ],
            ),
          ),
        ),
      )
    );
  }
}
