


import 'package:equipment_inventory/Service/userService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/userListTile.dart';

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
        return ListView.builder(
          itemCount: users.userList.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: UserListTile(users: users, index: index,),
            );
          }
        );
      },
    );
  }
}
