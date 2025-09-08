

import 'dart:convert';

import 'package:equipment_inventory/Model/equipmentModel.dart';
import 'package:equipment_inventory/Model/locationModel.dart';
import 'package:equipment_inventory/Model/propertyModel.dart';
import 'package:equipment_inventory/Service/apiService.dart';
import 'package:http/http.dart';

import 'package:collection/collection.dart';

class EquipmentService extends APIService{

  List<EquipmentModel> _equipmentList=[];
  late Map<String, List<EquipmentModel>> groupedByProperty={};
  late Map<String, Map<String, List<EquipmentModel>>> groupedByPropertyThenLocation={};

  List<EquipmentModel> get equipmentList => _equipmentList;

  void retrieveList() async {
    Response response = await this.get("api/v1/get-all-equipment-dto", {});

    if(response.body.isNotEmpty){
      List<dynamic> returnedList = jsonDecode(response.body);

      returnedList.forEach((item){
        EquipmentModel equipment = EquipmentModel.fromJson(item);

        if(!_equipmentList.any((e) => e.id == equipment.id)){
          _equipmentList.add(equipment);
        }
      });
      groupedByProperty =  groupBy(_equipmentList, (e) => e.location!.property!.name ?? "Property not found.");
      groupedByPropertyThenLocation = groupEquipment(_equipmentList);

      notifyListeners();
    }
  }




  Map<String, Map<String, List<EquipmentModel>>> groupEquipment(List<EquipmentModel> equipmentList) {

    return groupBy(equipmentList, (e) => e.location?.property?.name ?? "Property not found")
        .map((property, equipments) {
      // group the inner list by location
      final Map<String, List<EquipmentModel>> byLocation = groupBy(equipments, (e) => e.location!.name ?? "Location not found.");

      return MapEntry(property!, byLocation);
    });
  }

}