import 'dart:io';
import 'dart:typed_data';


import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'Service/camera_service.dart';

class CameraPage extends StatefulWidget {
  final Widget? image;
  const CameraPage({super.key, required this.image});

  @override
  State<CameraPage> createState() => _CameraPageState();
}




class _CameraPageState extends State<CameraPage> {


  @override
  void initState() {
    Provider.of<CameraService>(context, listen: false).disposeCamera();
    Provider.of<CameraService>(context, listen: false).initializeCamera(context);
    super.initState();
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
              color: AppColors.appWhite,
              height: 500,
              width: 300,
              child: pickedImageData != null? Image.memory(pickedImageData?? Uint8List(0)) : widget.image,

            ),



            // pick image buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [


                // camera button
                ElevatedButton(
                  onPressed: (){
                    pickImage(ImageSource.camera);
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
          ],
        ),
      )
    );
  }
}
