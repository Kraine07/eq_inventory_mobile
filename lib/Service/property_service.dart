

import 'dart:convert';

import 'package:equipment_inventory/Model/locationModel.dart';
import 'package:equipment_inventory/Model/propertyModel.dart';
import 'package:equipment_inventory/Service/api_service.dart';
import 'package:http/http.dart';

class PropertyService extends APIService {
  List<PropertyModel> _propertyList = [];
  List<LocationModel> _locationList = [];


  List<PropertyModel> get propertyList => _propertyList;
  List<LocationModel> get locationList => _locationList;



  set propertyList(List<PropertyModel> list){
    _propertyList = list;
    notifyListeners();
  }




  set locationList(List<LocationModel> list){
    _locationList = list;
    notifyListeners();
  }





  void retrievePropertyList() async{
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





  void retrieveLocationList() async{
    Response response = await this.get('api/v1/get-all-locations',  {});
    if(response.body.isNotEmpty){
      List<dynamic> returnedList = jsonDecode(response.body);
      returnedList.forEach((item){
        LocationModel returnedLocation = LocationModel.fromJson(item);
        if (!_locationList.any((locationFromList) =>
        returnedLocation.property?.id == locationFromList.property?.id  &&
            returnedLocation.name == locationFromList.name )) {
          _locationList.add(returnedLocation);
        }
      });
      _locationList.sort((a, b) => a.name!.compareTo(b.name.toString()));
      notifyListeners();

    }
  }



  List<LocationModel> retrieveLocationsAtProperty(PropertyModel property) {
    final locationsAtProperty = _locationList.where((location) => location.property?.id == property.id).toList();
     locationsAtProperty.sort((a, b) => a.name!.compareTo(b.name!));
     return locationsAtProperty;

  }

}