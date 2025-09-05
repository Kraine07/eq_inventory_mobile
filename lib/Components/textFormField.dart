import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';

class AppInputField extends StatefulWidget {
  final String? label;
  final TextEditingController controller;
  final bool obscureText;
  final Function(String?) validator;
  final Function(bool?) onChanged;
  final Widget icon;
  BorderStyle borderStyle;
  double  radius;

  AppInputField({
    super.key,
    this.label,
    required this.controller,
    required this.obscureText,
    required this.validator,
    required this.icon,
    required this.onChanged,
    this.borderStyle = BorderStyle.solid,
    this.radius = 8.0
  }
  );


  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  @override
  Widget build(BuildContext context) {
    return TextSelectionTheme(
      data: TextSelectionThemeData(
        selectionColor: AppColors.textSecondary
      ),
      child: TextFormField(
        cursorColor: AppColors.appWhite,
        obscureText: widget.obscureText,
        validator: (val)=> widget.validator(val),
        onChanged: (val)=> widget.onChanged,
        controller: widget.controller,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.appWhite
        ),
        decoration:  InputDecoration(
          prefixIcon: widget.icon,
          labelText: widget.label,
          
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            borderSide: BorderSide(
              color: AppColors.borderColor,
              style: widget.borderStyle
            )
          ),


          // focused border style
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                  color: AppColors.appWhite,
                  width: 3.0
              )
          ),


          // error border style
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                  color: AppColors.accentColor,
                  width: 1.0
              )
          ),

          // focused error border style
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.radius),
              borderSide: BorderSide(
                  color: AppColors.accentColor,
                  width: 3.0
              )
          )


        ),

      ),
    );
  }
}

