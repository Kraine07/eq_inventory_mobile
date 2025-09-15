


import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme.dart';
import 'icon.dart';

class AppButton extends StatefulWidget {

  final Function() onPressed;
  final String text;
  final bool showIcon;

  AppButton({
    super.key,
    required this.onPressed,
    this.text = "",
    this.showIcon = true,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressed,
      style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(20),
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
          Text(widget.text),
          AppIcon(
            icon: Symbols.chevron_right,
            weight: 500,
          ),
        ],
      ),
    );
  }
}
