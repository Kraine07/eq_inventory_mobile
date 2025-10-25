
import 'package:equipment_inventory/Components/heading.dart';
import 'package:equipment_inventory/DashboardScreens/equipmentScreen.dart';
import 'package:equipment_inventory/DashboardScreens/propertiesScreen.dart';
import 'package:equipment_inventory/DashboardScreens/reportsScreen.dart';
import 'package:equipment_inventory/DashboardScreens/usersScreen.dart';
import 'package:equipment_inventory/Model/userModel.dart';
import 'package:equipment_inventory/loadPage.dart';
import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import 'Service/app_header_service.dart';
import 'Service/user_service.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}




class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  late AppHeader appHeader;
  late TabController _tabController;
  late List<String> _headers;
  late List<Widget> _screens;
  bool _isAdmin = false;






  @override
  void initState() {
    super.initState();

    // get current auth/isAdmin (listen: false is required in initState)
    final userService = Provider.of<UserService>(context, listen: false);
    _isAdmin = userService.authUser?.isAdmin ?? false;

    // build headers & screens based on admin status
    _headers = _isAdmin
        ? ["Equipment", "Users", "Properties", "Reports"]
        : ["Equipment", "Reports"];

    _screens = [
      EquipmentScreen(),
      if (_isAdmin) UsersScreen(),
      if (_isAdmin) PropertiesScreen(),
      ReportsScreen(),
    ];

    // create controller with correct length
    _tabController = TabController(length: _headers.length, vsync: this);

    // get AppHeader provider instance and set initial header
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appHeader = Provider.of<AppHeader>(context, listen: false);
      appHeader.header = _headers[_tabController.index];

    });

    // listen for changes and update header
    _tabController.addListener(() {
      // optionally guard: avoid reacting while index is changing if desired
      if (!_tabController.indexIsChanging) {
        appHeader.header = _headers[_tabController.index];
      }
    });
  }






  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }





  Icon _iconFor(String header) {
    switch (header) {
      case "Equipment":
        return Icon(Symbols.kitchen);
      case "Users":
        return Icon(Symbols.group);
      case "Properties":
        return Icon(Symbols.apartment);
      case "Reports":
        return Icon(Symbols.bar_chart);
      default:
        return Icon(Icons.help_outline);
    }
  }





  @override
  Widget build(BuildContext context) {
    // keep reading user info for display (no listening side-effects here)
    UserModel? authUser = Provider.of<UserService>(context, listen: false).authUser;
    String? firstName = authUser?.firstName?.toUpperCase();
    String? lastName = authUser?.lastName?.toUpperCase();

    return Provider.of<UserService>(context, listen: false).isLoggedIn ?
      Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 960),
        child: Scaffold(
          body: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 960),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    //
                    Heading(
                      name: "$lastName, $firstName",
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: _screens,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Material(
            color: AppColors.appDarkBlue.withValues(alpha: 0.8),
            child: TabBar(
              controller: _tabController,
              labelStyle: TextStyle(fontSize: 13, color: AppColors.accentColor),
              indicator: BoxDecoration(),
              indicatorColor: AppColors.accentColor,
              dividerHeight: 0,
              tabs: _headers
                  .map((h) => Tab(text: h, icon: _iconFor(h)))
                  .toList(),
            ),
          ),
        ),
      ),
    )


        :


    const LoadPage();
  }
}











//
// class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin{
//
//
//
//   late AppHeader appHeader;
//   late TabController _tabController;
//
//   late List<String> _headers;
//   late List<Widget> _screens;
//   bool _isAdmin = false;
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     // get current auth/isAdmin (listen: false is required in initState)
//     final userService = Provider.of<UserService>(context, listen: false);
//     _isAdmin = userService.authUser?.isAdmin ?? false;
//
//     // build headers & screens based on admin status
//     _headers = _isAdmin
//         ? ["Equipment", "Users", "Properties", "Reports"]
//         : ["Equipment", "Reports"];
//
//     _screens = [
//       EquipmentScreen(),
//       if (_isAdmin) UsersScreen(),
//       if (_isAdmin) PropertiesScreen(),
//       ReportsScreen(),
//     ];
//
//     // create controller with correct length
//     _tabController = TabController(length: _headers.length, vsync: this);
//
//     // get AppHeader provider instance and set initial header
//     appHeader = Provider.of<AppHeader>(context, listen: false);
//     appHeader.header = _headers[_tabController.index];
//
//     // listen for changes and update header
//     _tabController.addListener(() {
//       // optionally guard: avoid reacting while index is changing if desired
//       if (!_tabController.indexIsChanging) {
//         appHeader.header = _headers[_tabController.index];
//       }
//     });
//   }
//
//
//
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//      UserModel? authUser = Provider.of<UserService>(context, listen: false).authUser;
//      String? firstName = authUser?.firstName?.toUpperCase();
//      String? lastName = authUser?.lastName?.toUpperCase();
//
//     return  Center(
//       child: ConstrainedBox(
//         constraints: BoxConstraints(
//           maxWidth: 960
//         ),
//         child: Scaffold(
//           body: Center(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxWidth: 960
//               ),
//               child: Container(
//                 margin: EdgeInsets.symmetric(vertical: 5),
//                 decoration: BoxDecoration(
//                   // color: AppColors.appBlue
//                 ),
//                 child: Column(
//                   children: [
//                     Heading(name: "$lastName, $firstName",),
//
//                     Expanded(
//                       child: TabBarView(
//                         controller: _tabController,
//                         children:  _screens
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//
//
//           bottomNavigationBar: Material(
//             color: AppColors.appDarkBlue.withValues(alpha: 0.8),
//             child: TabBar(
//               controller: _tabController,
//               labelStyle: TextStyle(
//                 fontSize: 13,
//                 color: AppColors.accentColor
//               ),
//               indicator: BoxDecoration(),
//               indicatorColor: AppColors.accentColor,
//               dividerHeight: 0,
//
//
//               tabs: [
//                 Tab(
//                   text: "Equipment",
//                   icon: Icon(Symbols.kitchen),
//                 ),
//                 if (Provider.of<UserService>(context).authUser!.isAdmin?? false) Tab(
//                   text: "Users",
//                   icon: Icon(Symbols.group),
//                 ),
//                 if (Provider.of<UserService>(context).authUser!.isAdmin?? false) Tab(
//                   text: "Properties",
//                   icon: Icon(Symbols.apartment),
//                 ),
//                 Tab(
//                   text: "Reports",
//                   icon: Icon(Symbols.bar_chart),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
