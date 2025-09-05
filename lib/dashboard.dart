
import 'package:equipment_inventory/Components/heading.dart';
import 'package:equipment_inventory/Components/icon.dart';
import 'package:equipment_inventory/Components/textFormField.dart';
import 'package:equipment_inventory/Model/userModel.dart';
import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import 'Service/userService.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final TextEditingController _searchController = TextEditingController();



  @override
  Widget build(BuildContext context) {

     UserModel? authUser = Provider.of<UserService>(context, listen: false).authUser;
     String? firstName = authUser?.firstName?.toUpperCase();
     String? lastName = authUser?.lastName?.toUpperCase();

    return  Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 1200
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.appBlue
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Heading(searchController: _searchController,showIcon: false,name: "$lastName, $firstName",),

                ],
              ),
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(onPressed: (){},
            child: Text(
              "Button",
              style: TextStyle(color: AppColors.appWhite),
            )
        ),

        ElevatedButton(onPressed: (){},
            child: Text(
              "Button",
              style: TextStyle(color: AppColors.appWhite),
            )
        ),

        ElevatedButton(onPressed: (){},
            child: Text(
              "Button",
              style: TextStyle(color: AppColors.appWhite),
            )
        ),

        ElevatedButton(onPressed: (){},
            child: Text(
              "Button",
              style: TextStyle(color: AppColors.appWhite),
            )
        )
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }
}
