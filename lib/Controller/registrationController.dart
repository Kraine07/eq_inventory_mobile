import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:equipment_inventory/Components/button.dart';
import 'package:equipment_inventory/Components/heading.dart';
import 'package:equipment_inventory/Components/icon.dart';
import 'package:equipment_inventory/Components/textFormField.dart';
import 'package:equipment_inventory/Model/userModel.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../Model/roleType.dart';
import '../Service/userService.dart';
import '../theme.dart';

class RegistrationController extends StatefulWidget {
  final UserModel? user;
  const RegistrationController({super.key, required this.user});

  @override
  State<RegistrationController> createState() => _RegistrationControllerState();
}

class _RegistrationControllerState extends State<RegistrationController> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late bool _isAdmin ;



  @override
  void initState() {
    super.initState();
    _emailController = widget.user != null ? TextEditingController(text: widget.user!.email) : TextEditingController();
    _firstNameController = widget.user != null ? TextEditingController(text: widget.user!.firstName) : TextEditingController();
    _lastNameController = widget.user != null ? TextEditingController(text: widget.user!.lastName) : TextEditingController();
    _isAdmin = widget.user != null ? widget.user!.isAdmin! : false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }


  // register user
  void registerUser(BuildContext context) async{
    UserService userService = UserService();

    if(_formKey.currentState!.validate()){
      // attempt to register
      final registerResponse = await userService.register(
          endpoint: "api/v1/register",
          registrationModel: {
            "email" : _emailController.text,
            "firstName" : _firstNameController.text,
            "lastName" : _lastNameController.text,
          },
        params: _isAdmin ? "admin" : "editor"
      );

      final Map<String,dynamic> responseBody = jsonDecode(registerResponse.body);
      print(responseBody);
    }
  }


  @override
  Widget build(BuildContext context) {


    String? nameValidator(String? value) {
      if (value == null || value.isEmpty) {
        return "This field is required.";
      }
    }

    return Center(

      child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Logo and instructions
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Registration",
                      style: TextStyle(
                        fontSize: 24
                      ),
                    ),
                    Text("Please fill out the form below to register.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16
                      ),
                    )
                  ],
                ),


                // FORM FIELDS

                //first name
                AppInputField(
                  label: "First Name",
                  controller: _firstNameController,
                  obscureText: false,
                  validator: nameValidator,
                  icon: AppIcon(icon: Symbols.id_card, weight: 200),
                  onChanged: (val){},
                ),



                //Last name
                AppInputField(
                  label: "Last Name",
                  controller: _lastNameController,
                  obscureText: false,
                  validator: nameValidator,
                  icon: AppIcon(icon: Symbols.id_card, weight: 200),
                  onChanged: (val){},
                ),


                //Email
                AppInputField(
                  readOnly: widget.user != null ? true : false,
                  keyboard: TextInputType.emailAddress,
                  label: "Email",
                  controller: _emailController,
                  obscureText: false,
                  validator: (value) {
                    return EmailValidator.validate(value ?? '') ? null : 'Invalid email';
                  },
                  icon: AppIcon(icon: Symbols.id_card, weight: 200),
                  onChanged: (val){},
                ),




                //is admin switch and label
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          _isAdmin = !_isAdmin;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 20, 12),
                        child: Text("Is Admin",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16
                          )
                        ),
                      ),
                    ),

                    Switch(
                        inactiveTrackColor: AppColors.appLightBlue, // background color
                        activeTrackColor: AppColors.accentColor, // active background color,
                        thumbColor: WidgetStatePropertyAll<Color>(AppColors.appDarkBlue),
                        activeThumbColor: AppColors.appLightBlue,
                        trackOutlineColor: WidgetStatePropertyAll<Color>(AppColors.borderColor),
                        value: _isAdmin,
                        onChanged: (value){
                          setState(() {
                            _isAdmin = value;
                          });
                        },

                      thumbIcon: _isAdmin ?
                      WidgetStatePropertyAll<Icon>(
                        Icon(Symbols.check)
                      ):
                      WidgetStatePropertyAll<Icon>(
                          Icon(Symbols.close)
                      ),
                    )
                  ],
                ),

                
                // submit button
                AppButton(onPressed: (){
                  registerUser(context);
                }, text: widget.user != null ? "Update User" : "Create User",)

              ],
            ),
          )
      ),
    );
  }
}
