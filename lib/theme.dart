import 'package:flutter/material.dart';

class AppColors{
  static const Color appDarkBlue = Color(0xFF041C32);
  static const Color appDarkBlue40 = Color(0x66041C32);
  static const Color appBlue = Color(0xFF04293A);
  static const Color appLightBlue = Color(0xFF064663);
  static const Color appLightBlue40 = Color(0x66064663);
  static const Color accentColor = Color(0xFFECB365);
  static const Color accentColor40 = Color(0x66ECB365);
  static const Color appWhite = Color(0xFFD7D7D7);
  static const Color borderColor = Color(0xFF616161);
  static const Color textSecondary = Color(0xFF777777);
  static const Color activeColor = Color(0xFF055300);
  static const Color inactiveColor = Color(0xFFFF3232);
}


final ThemeData appTheme = ThemeData(

  // COLOR SCHEME
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.appLightBlue,
    secondary: AppColors.appLightBlue,
    tertiary: AppColors.accentColor,
    surface: AppColors.appLightBlue,
    error: AppColors.accentColor,
    onPrimary: AppColors.appWhite,
    onSecondary: AppColors.appWhite,
    onTertiary: AppColors.appWhite,
    onSurface: AppColors.appWhite,
    onError: AppColors.appWhite,
  ),




  //INPUT DECORATION
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    prefixIconColor: AppColors.appWhite,
    filled: true,
    fillColor: AppColors.appLightBlue,
    labelStyle: TextStyle(
        fontSize: 16,
        color: AppColors.textSecondary),



  ),


  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      foregroundColor: AppColors.appWhite,
    ),
  ),



  // BOTTOM SHEET THEME
  bottomSheetTheme: BottomSheetThemeData(
    showDragHandle: true,
    modalBackgroundColor: AppColors.appLightBlue,
    modalBarrierColor: AppColors.appDarkBlue.withValues(alpha: 0.8),


    constraints: BoxConstraints(
      maxWidth: 960,
      maxHeight: 680,
    ),

    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero
    )
  ),



    //dialog theme
  dialogTheme: DialogThemeData(

    insetPadding: EdgeInsets.all(8),
    backgroundColor: AppColors.appLightBlue,

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8)
    ),

    titleTextStyle: TextStyle(
      color: AppColors.appWhite,
      fontWeight: FontWeight.w300,
      fontSize: 24,
    )

  ),


);