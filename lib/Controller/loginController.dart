import 'dart:convert';
import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:equipment_inventory/Components/updatePassword.dart';
import 'package:equipment_inventory/Model/userModel.dart';
import 'package:equipment_inventory/Service/userService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../Components/icon.dart';
import '../Components/textFormField.dart';
import '../loadPage.dart';
import '../theme.dart';

class LoginController extends StatefulWidget {
  const LoginController({super.key});

  @override
  State<LoginController> createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final String loginEndpoint = "api/v1/login";

  // TODO revisit unchanged method




  // Email validator
  String? emailValidator(value) {
    return EmailValidator.validate(value ?? '') ? null : 'Invalid email';
  }




  // Password validator
  String? passwordValidator(String? value) {
    // check for null/empty field
    if (value == null || value.isEmpty) {
      return "Password is required.";
    }

    // check regex match
    final regex = RegExp(r'^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^*&()]).{8,}$');
    if (!regex.hasMatch(value)) {
      return "Password must be at least 8 characters,\ninclude upper, lower, number & special char.";
    }

    // if valid
    return null;
  }





  // Sign in
  void attemptLogin(BuildContext context) async{
    UserService userService =  UserService();

    if (_formKey.currentState!.validate()) {

      final Response loginResponse = await userService.login(loginEndpoint, _emailController.text, _passwordController.text);

      final Map<String,dynamic> responseBody = jsonDecode(loginResponse.body);


      // check for login errors
      if(responseBody.containsKey("error")){

        final  String errorMessage = responseBody['error'];

        // show error message
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: AppColors.appBlue,
              content: Text(errorMessage ,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.accentColor,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
        );
      }


      // show update password form if password is temporary
      else if(responseBody.containsKey("message")){
        showCupertinoSheet(
            context: context,
            useNestedNavigation: true,
            builder: (BuildContext sheetContext){
              return UpdatePassword(sheetContext: sheetContext);
            }
        );
      }


      else {
        // Set AuthUser
        UserModel? authUser;
        authUser = UserModel.fromJson(responseBody);
        Provider.of<UserService>(context, listen: false).setAuthUser = authUser;
        Provider.of<UserService>(context, listen: false).isLoggedIn = true;

        // Load Dashboard
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoadPage()));
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return  Center(
      child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: 480
          ),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      // Logo & text
                      Column(
                        children: [
                          Image.asset('assets/images/eq_logo_white.png'),
                          Text("You have mass and occupy space, therefore you matter.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 20,),

                      // Email Input
                      AppInputField(
                        keyboard: TextInputType.emailAddress,
                          label: "Email",
                          controller: _emailController,
                          obscureText: false,
                          validator: emailValidator,
                          icon: AppIcon(
                            icon: Symbols.mail_outline,
                            weight: 200,
                          ),
                          onChanged: (val){}),



                      // Password input
                      AppInputField(
                          icon: AppIcon(
                            icon: Symbols.lock_outline,
                            weight: 200,
                          ),
                          label: "Password",
                          controller: _passwordController,
                          obscureText: true,
                          validator: passwordValidator,
                          onChanged: (val){}),


                      // Forgot password
                      TextButton(onPressed: (){},
                          child: Text("Forgot Password",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.appWhite
                            ),)
                      ),



                      //Submit button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => attemptLogin(context),
                          style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric( vertical: 20),
                              backgroundColor: AppColors.appDarkBlue,
                              foregroundColor: AppColors.appWhite,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)
                              ),
                              side: BorderSide(
                                  color: AppColors.accentColor,
                                  width: 1.0
                              )
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Text("Sign in"),
                              AppIcon(
                                icon: Symbols.chevron_right,
                                weight: 500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                ),
              )
          )
      ),
    );
  }
}
