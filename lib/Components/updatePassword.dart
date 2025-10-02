


import 'package:equipment_inventory/Components/button.dart';
import 'package:equipment_inventory/Components/icon.dart';
import 'package:equipment_inventory/Components/textFormField.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme.dart';

class UpdatePassword extends StatefulWidget {
  final BuildContext sheetContext;
  const UpdatePassword({super.key, required this.sheetContext});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final String updatePasswordEndpoint = "api/v1/updatePassword";


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 480
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 40,
                children: [
                  Column(
                    children: [
                      Text("Update Password",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w300
                      ),
                      ),


                    ],
                  ),

                  Column(
                    spacing: 20,
                    children: [
                      AppInputField(
                        label: "Old Password",
                          controller: _oldPasswordController,
                          obscureText: true,
                          validator: (val) => null,
                          icon: AppIcon(
                              icon: Symbols.lock_outline,
                              weight: 500
                          ),
                          onChanged: (val) => {}
                      ),
          
          
                      AppInputField(
                        label: "New Password",
                          controller: _newPasswordController,
                          obscureText: true,
                          validator: (val) => null,
                          icon: AppIcon(
                              icon: Symbols.lock_outline,
                              weight: 500
                          ),
                          onChanged: (val) => {}
                      ),
          

                      AppInputField(
                        label: "Confirm New Password",
                          controller: _confirmPasswordController,
                          obscureText: true,
                          validator: (val) => null,
                          icon: AppIcon(
                              icon: Symbols.lock_outline,
                              weight: 500
                          ),
                          onChanged: (val) => {}
                      ),


                      AppButton(
                          onPressed: (){
                            Navigator.of(widget.sheetContext, rootNavigator: true).pop();
                          },
                      )

                    ],
                  )
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
