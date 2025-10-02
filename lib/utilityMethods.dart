

import 'package:flutter/material.dart';

import 'Components/updatePassword.dart';

class UtilityMethods {




// To capitalize the first letter and make the rest lowercase:
  static String capitalizeFirstLetterOnly(String s) {
    if (s.isEmpty) {
      return "";
    }
    return "${s[0].toUpperCase()}${s.substring(1).toLowerCase()}";
  }






  static String capitalizeEachWord(String text) {
    if (text.isEmpty) {
      return "";
    }

    // Split the string into words using space as a delimiter.
    // This will also handle multiple spaces between words correctly.
    List<String> words = text
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.isEmpty) {
      return ""; // Handle case where string might only contain spaces
    }

    // Capitalize the first letter of each word and make the rest lowercase (optional).
    List<String> capitalizedWords = words.map((word) {
      if (word
          .isEmpty) { // Should not happen due to 'where' clause, but good for safety
        return "";
      }
      String firstLetter = word[0].toUpperCase();
      String restOfWord = word
          .substring(1)
          .toLowerCase(); // Make rest lowercase
      return "$firstLetter$restOfWord";
    }).toList();

    // Join the capitalized words back with a single space.
    return capitalizedWords.join(' ');
  }



  static void showUpdatePassword(BuildContext context){
    showBottomSheet(
        context: context,
        builder: (BuildContext sheetContext){
          return UpdatePassword(sheetContext: sheetContext);
        }
    );

  }

}