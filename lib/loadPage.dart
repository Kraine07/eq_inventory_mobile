

import 'package:flutter/material.dart';
import 'package:equipment_inventory/dashboard.dart';
import 'package:provider/provider.dart';

import 'Controller/loginController.dart';
import 'Service/userService.dart';

class LoadPage extends StatelessWidget {
  const LoadPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: false);

    return Scaffold(
      body: userService.isLoggedIn
          ? const Dashboard()
          : const LoginController(),
    );
  }
}

