

import 'package:flutter/material.dart';
import 'package:equipment_inventory/dashboard.dart';
import 'package:provider/provider.dart';

import 'Controller/loginController.dart';
import 'Service/userService.dart';

class LoadPage extends StatelessWidget {
  const LoadPage({super.key});

  @override
  Widget build(BuildContext context) {

    // check isLoggedIn variable to determine which page to load
    // return Provider.of<UserService>(context, listen: false).isLoggedIn ? const Dashboard() : const LoginController();
    return Dashboard();
  }
}
