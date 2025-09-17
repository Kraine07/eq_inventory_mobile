
import 'package:equipment_inventory/Components/heading.dart';
import 'package:equipment_inventory/DashboardScreens/equipmentScreen.dart';
import 'package:equipment_inventory/DashboardScreens/propertiesScreen.dart';
import 'package:equipment_inventory/DashboardScreens/reportsScreen.dart';
import 'package:equipment_inventory/DashboardScreens/usersScreen.dart';
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

    return  DefaultTabController(
      length: Provider.of<UserService>(context).authUser!.isAdmin?? false? 4: 2,
      child: Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 960
            ),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                // color: AppColors.appBlue
              ),
              child: Column(
                children: [
                  Heading(searchController: _searchController,showIcon: false,name: "$lastName, $firstName",),

                  Expanded(
                    child: TabBarView(
                      children: [
                        EquipmentScreen(),
                        if (Provider.of<UserService>(context).authUser!.isAdmin?? false) UsersScreen(),
                        if (Provider.of<UserService>(context).authUser!.isAdmin?? false) PropertiesScreen(),
                        ReportsScreen(),
                    ]),
                  ),

                ],
              ),
            ),
          ),
        ),



        bottomNavigationBar: Material(
          color: AppColors.appDarkBlue,
          child: TabBar(

            labelStyle: TextStyle(
              fontSize: 13,
              color: AppColors.accentColor
            ),
            indicator: BoxDecoration(),
            indicatorColor: AppColors.accentColor,
            dividerHeight: 0,


            tabs: [
              Tab(
                text: "Equipment",
                icon: Icon(Symbols.kitchen),
              ),
              if (Provider.of<UserService>(context).authUser!.isAdmin?? false) Tab(
                text: "Users",
                icon: Icon(Symbols.group),
              ),
              if (Provider.of<UserService>(context).authUser!.isAdmin?? false) Tab(
                text: "Properties",
                icon: Icon(Symbols.apartment),
              ),
              Tab(
                text: "Reports",
                icon: Icon(Symbols.bar_chart),
              )
            ],
          ),
        ),
      ),
    );
  }
}
