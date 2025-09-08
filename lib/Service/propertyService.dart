

import 'dart:convert';

import 'package:equipment_inventory/Model/propertyModel.dart';
import 'package:equipment_inventory/Service/apiService.dart';
import 'package:http/http.dart';

class PropertyService extends APIService {
  List<PropertyModel> _propertyList = [];


  List<PropertyModel> get propertyList => _propertyList;

  set propertyList(List<PropertyModel> list){
    _propertyList = list;
    notifyListeners();
  }

  void retrieveList() async{
    Response response = await this.get('api/v1/get-all-properties',  {});
    if(response.body.isNotEmpty){
      List<dynamic> returnedList = jsonDecode(response.body);
      returnedList.forEach((item){
        PropertyModel property = PropertyModel.fromJson(item);
        if (!_propertyList.any((p) => p.id == property.id)) {
          _propertyList.add(property);
        }
      });
      _propertyList.sort((a, b) => a.name!.compareTo(b.name.toString()));
      notifyListeners();
    }
  }
}