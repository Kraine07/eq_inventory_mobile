

import 'package:equipment_inventory/equipment_image_page.dart';
import 'package:flutter/material.dart';
import 'package:equipment_inventory/dashboard.dart';
import 'package:provider/provider.dart';

import 'Controller/loginController.dart';
import 'Service/user_service.dart';

class LoadPage extends StatelessWidget {
  const LoadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: false);

    return Scaffold(
      body: userService.isLoggedIn && userService.authUser != null
          ? const Dashboard()
          : const LoginController(),
    );
    // return CameraPage();

    // password for daffy duck = 1RGi!r!^y^nP
  }
}

