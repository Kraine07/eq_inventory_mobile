import 'dart:io';
import 'dart:typed_data';


import 'package:equipment_inventory/Components/button.dart';
import 'package:equipment_inventory/app_camera_preview.dart';
import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CameraService>(context, listen: false).disposeCamera();
    });
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
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: 700,
                maxWidth: 300,
              ),
              color: AppColors.appWhite,
              child: pickedImageData != null? Image.memory(pickedImageData?? Uint8List(0)) : widget.image,

            ),



            // pick image buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [


                // camera button
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AppCameraPreview()));
                    // pickImage(ImageSource.camera);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.appWhite
                  ),
                  child: Text("Camera",
                  ),
                ),


                // gallery button
                ElevatedButton(
                  onPressed: (){
                    pickImage(ImageSource.gallery);
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.appWhite
                  ),
                  child: Text("Gallery"),
                )
              ],
            ),

            AppButton(text: "Upload", onPressed: (){
              Provider.of<CameraService>(context, listen: false).uploadImage(widget.equipmentId!, context);
            })
          ],
        ),
      )
    );
  }
}
