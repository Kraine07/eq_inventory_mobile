


import 'package:equipment_inventory/Components/button.dart';
import 'package:equipment_inventory/Components/userTile.dart';
import 'package:equipment_inventory/Controller/registrationController.dart';
import 'package:equipment_inventory/Service/userService.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../Components/icon.dart';
import '../Model/roleType.dart';
import '../theme.dart';
import '../utilityMethods.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {


  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
      Provider.of<UserService>(context, listen: false).retrieveList()
    });
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Consumer<UserService>(
      builder: (BuildContext context, UserService users, Widget? child) {

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // NEW USER BUTTON
            InkWell(
              onTap: (){
                showBottomSheet(
                  constraints: BoxConstraints(
                    maxWidth: 960
                  ),
                    context: context, 
                    builder: (BuildContext sheetContext) =>
                        Padding(
                          padding: const EdgeInsets.all(20.0),

                          // show registration form
                          child: RegistrationController(user: null,),
                        )
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.appDarkBlue,
                  borderRadius: BorderRadius.circular(8)
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  spacing: 20,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(icon: Symbols.person_add, weight: 200, size: 38,),
                    Text("New User",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              
              ),
            ),
            
            
            // USER LIST
            UserTile(users: users.userList)
          ],
        );

      },
    );
  }
}
