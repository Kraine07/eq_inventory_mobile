


import 'package:flutter/cupertino.dart';

class  YearMonth {

  late final int year;
  late final int month;

  YearMonth({required this.year, required this.month});

  factory YearMonth.fromString(String date){
    if(date.isNotEmpty){
      var parts = date.split('-');
      return YearMonth(year: int.parse(parts[0]), month: int.parse(parts[1]));
    }
    return YearMonth(year: 0, month: 0);
  }


  @override
  String toString() => "$year-${month.toString().padLeft(2, '0')}";
}