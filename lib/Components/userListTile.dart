import 'package:equipment_inventory/Service/userService.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../Model/roleType.dart';
import '../theme.dart';
import '../utilityMethods.dart';
import 'icon.dart';

class UserListTile extends StatefulWidget {

  final UserService users;
  final int index;


  const UserListTile({
    super.key,
    required this.users,
    required this.index
  });

  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.users.userList[widget.index].isSuspended?? true ? AppColors.appDarkBlue : AppColors.appBlue,
      ),
      padding: EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        leading: widget.users.userList[widget.index].isSuspended?? true ? AppIcon(icon: Symbols.gpp_bad, weight: 300,size: 32, color: AppColors.textSecondary,) : AppIcon(icon: Symbols.verified_user, weight: 300,size: 32,),
        title: Text(UtilityMethods.capitalizeEachWord("${widget.users.userList[widget.index].lastName}, ${widget.users.userList[widget.index].firstName}")),
        titleTextStyle: widget.users.userList[widget.index].isSuspended?? true ?
        TextStyle(
          decoration: TextDecoration.lineThrough,
          color: AppColors.inactiveColor,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w300,
          fontSize: 24,
        )
            :
        TextStyle(
          color: AppColors.activeColor,
          fontWeight: FontWeight.w300,
          fontSize: 24,
        ),
        subtitle: Text(widget.users.userList[widget.index].role!.roleType == RoleType.ADMINISTRATOR? "ADMINISTRATOR" : "EDITOR"),
        subtitleTextStyle: widget.users.userList[widget.index].isSuspended?? true ?
        TextStyle(
          color: AppColors.textSecondary,
          fontStyle: FontStyle.italic,
          fontSize: 14,
        )
            :
        TextStyle(
            fontSize: 14
        ),
        trailing: widget.users.userList[widget.index].isSuspended ?? true ? AppIcon(icon: Symbols.person_off, weight: 300, size: 32, color: AppColors.textSecondary,) : AppIcon(icon: Symbols.person_check, weight: 300, size: 32,),
      ),
    );
  }
}
