
import 'package:equipment_inventory/Service/model_service.dart';
import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Service/app_header_service.dart';
import 'Service/camera_service.dart';
import 'Service/equipment_service.dart';
import 'Service/manufacturer_service.dart';
import 'Service/property_service.dart';
import 'Service/user_service.dart';
import 'loadPage.dart';


void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>UserService()),
          ChangeNotifierProvider(create: (_)=>EquipmentService()),
          ChangeNotifierProvider(create: (_)=>PropertyService()),
          ChangeNotifierProvider(create: (_)=>ManufacturerService()),
          ChangeNotifierProvider(create: (_)=>ModelService()),
          ChangeNotifierProvider(create: (_)=>CameraService()),
          ChangeNotifierProvider(create: (_)=>AppHeader()),
        ],
      child: const MainApp(),
    )

  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: LoadPage(),
    );
  }
}