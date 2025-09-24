

import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';

class MessageHandler{



  static showMessage(BuildContext context, String message, bool isSuccessMessage){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 10),
          backgroundColor: isSuccessMessage ? AppColors.activeColor : AppColors.accentColor,
          content: Text(message ,
            textAlign: TextAlign.center,
            style:  TextStyle(
                color: isSuccessMessage ? AppColors.appWhite : AppColors.appBlue,
                fontWeight: FontWeight.bold
            ),
          ),
        )
    );
  }

}