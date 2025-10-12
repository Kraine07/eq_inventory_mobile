
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';


import '../Controller/registrationController.dart';
import '../Model/roleType.dart';
import '../Model/userModel.dart';
import '../Service/user_service.dart';
import '../theme.dart';
import '../utilityMethods.dart';
import 'icon.dart';

class UserTile extends StatefulWidget {
  final List<UserModel> users;
  const UserTile({super.key, required this.users});

  @override
  State<UserTile> createState() => _UserTileState();

}


class _UserTileState extends State<UserTile> {
  late final UserModel? authUser;

  @override
  void initState() {
    authUser = Provider.of<UserService>(context, listen: false).authUser;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ExpansionPanelList.radio(
            materialGapSize: 20,
            expandedHeaderPadding: EdgeInsets.symmetric(vertical: 20),
            dividerColor: AppColors.appLightBlue,
            children: widget.users.map((user) {
              return ExpansionPanelRadio(
                backgroundColor: AppColors.appBlue.withValues(alpha: 0.4),
                value: widget.users.indexOf(user),
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      spacing: 20,
                      children: [
                        user.isSuspended ?? true ?
                        AppIcon(icon: Symbols.person_off, weight: 300, size: 32, color: AppColors.textSecondary,) :
                        user.isTemporaryPassword?? false? AppIcon(icon: Symbols.person_alert, weight: 300, size: 32, color: AppColors.accentColor,) : AppIcon(icon: Symbols.person_check, weight: 300, size: 32,),

                        //
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                          child: Column(
                            spacing: 8,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // user name
                              Text(UtilityMethods.capitalizeEachWord("${user.firstName} ${user.lastName}"),
                                textAlign: TextAlign.start,
                                style: user.isSuspended ?? true ?
                                TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: AppColors.textSecondary,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.textSecondary,
                                ) : user.isTemporaryPassword?? false?
                                TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.accentColor,
                                ):
                                TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  // color: AppColors.activeColor
                                ),
                              ),


                              // user role
                              Text(user.role!.roleType == RoleType.ADMINISTRATOR ? "ADMINISTRATOR":"EDITOR",
                                style: user.isSuspended ?? true ?
                                TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: AppColors.textSecondary,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.textSecondary,
                                ) : user.isTemporaryPassword?? false?
                                TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: AppColors.accentColor,
                                ):
                                TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  // color: AppColors.activeColor
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },

                // expanded information
                body: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.appBlue.withValues(alpha: 0.4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // email address
                        Text(user.email ?? ""),

                        // action buttons
                        Visibility(
                          visible: user.id != authUser!.id,
                          child: Row(
                            spacing: 24,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              // suspend/activate button
                              user.isSuspended ?? true ?
                              AppIcon(icon: Symbols.check_circle, size: 36, weight: 200,color: AppColors.accentColor,):
                              AppIcon(icon: Symbols.cancel, size: 36, weight: 200,color: AppColors.accentColor,),

                              //edit button
                              InkWell(
                                  onTap:(){
                                    showBottomSheet(
                                        constraints: BoxConstraints(
                                            maxWidth: 960
                                        ),
                                        context: context,
                                        builder: (BuildContext sheetContext) =>
                                            RegistrationController(user: user,)
                                    );
                                  },
                                  child: AppIcon(icon: Symbols.edit_square, size: 36, weight: 200,color: AppColors.activeColor,)
                              ),

                              //delete button
                              InkWell(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text("Delete user?"),
                                      content: Text(
                                        "Are you sure you want to delete "
                                            "${UtilityMethods.capitalizeEachWord("${user.firstName ?? ''} ${user.lastName ?? ''}")}?",
                                      ),

                                      actionsAlignment: MainAxisAlignment.spaceEvenly,

                                      actions: [
                                        TextButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          child: Text("Cancel",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w200,
                                            color: AppColors.appWhite
                                          ),
                                          ),
                                        ),


                                        TextButton(
                                          style: ButtonStyle(
                                            shape: WidgetStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6),
                                            )),
                                            backgroundColor: WidgetStatePropertyAll<Color>(AppColors.accentColor),
                                            foregroundColor: WidgetStatePropertyAll<Color>(AppColors.appDarkBlue),
                                            padding: WidgetStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(horizontal: 36, vertical: 12)),
                                          ),
                                          onPressed: (){

                                            //TODO: interact with backend to delete user
                                            Navigator.pop(context);
                                          },
                                          child: Text("Yes",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              // color: AppColors.appWhite
                                            ),
                                          ),
                                        ),

                                      ],

                                    )

                                  );
                                },
                                  child: AppIcon(icon: Symbols.delete, size: 36, weight: 200,color: AppColors.inactiveColor,)
                              )
                            ],
                          ),
                        )
                      ],
                    )
                ),
              );
            }).toList(),

          ),
        ),
      ),
    );
  }
}
