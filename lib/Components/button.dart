


import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme.dart';
import 'icon.dart';

class AppButton extends StatefulWidget {

  final Function() onPressed;

  const AppButton({super.key, required this.onPressed});

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: widget.onPressed,
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
    );
  }
}
