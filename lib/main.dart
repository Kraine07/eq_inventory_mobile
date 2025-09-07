
import 'package:equipment_inventory/dashboard.dart';
import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Service/propertyService.dart';
import 'Service/userService.dart';
import 'loadPage.dart';


void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>UserService()),
          ChangeNotifierProvider(create: (_)=>PropertyService()),
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
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(
          foregroundColor: AppColors.appWhite,
          backgroundColor: AppColors.appBlue,
          title: const Text("Equipment Inventory",),
        ),
        body: LoadPage(),
      ),
    );
  }
}