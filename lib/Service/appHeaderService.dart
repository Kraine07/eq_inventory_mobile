

import 'package:flutter/cupertino.dart';

class AppHeader extends ChangeNotifier{
  String? _header ;

  String? get header => _header;

  set header(String? val){
    _header = val;
    notifyListeners();
  }

}