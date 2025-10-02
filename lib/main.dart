
import 'package:equipment_inventory/Service/modelService.dart';
import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Service/appHeaderService.dart';
import 'Service/equipmentService.dart';
import 'Service/manufacturerService.dart';
import 'Service/propertyService.dart';
import 'Service/userService.dart';
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