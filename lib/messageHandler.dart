

import 'package:equipment_inventory/theme.dart';
import 'package:flutter/material.dart';

class MessageHandler {


  // static showMessage(BuildContext context, String message,
  //     bool isSuccessMessage) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         duration: Duration(seconds: 10),
  //         backgroundColor: isSuccessMessage ? AppColors.activeColor : AppColors
  //             .accentColor,
  //         content: Text(message,
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //               color: isSuccessMessage ? AppColors.appWhite : AppColors
  //                   .appBlue,
  //               fontWeight: FontWeight.bold
  //           ),
  //         ),
  //       )
  //   );
  // }


// import 'package:flutter/material.dart';


  static showMessage(BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 5),
    bool isSuccessMessage = true,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (ctx) =>
          Positioned(
            bottom: 20, // distance above bottomsheet
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSuccessMessage ? AppColors.activeColor : AppColors.accentColor,

                ),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
    );

    // Insert into Overlay
    overlay.insert(overlayEntry);

    // Auto-remove after duration
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

}