

import 'dart:collection';
import 'dart:convert';

import 'package:equipment_inventory/Model/equipmentModel.dart';
import 'package:equipment_inventory/Model/locationModel.dart';
import 'package:equipment_inventory/Model/propertyModel.dart';
import 'package:equipment_inventory/Service/apiService.dart';
import 'package:http/http.dart';

import 'package:collection/collection.dart';

class EquipmentService extends APIService{

  List<EquipmentModel> _equipmentList=[];
  late Map<PropertyModel?, List<EquipmentModel>> groupedByProperty={};
  late Map<PropertyModel?, Map<LocationModel?, List<EquipmentModel>>> groupedByPropertyThenLocation={};

  late List<LocationModel> locationsOnProperty=[];
  late List<EquipmentModel> equipmentAtLocation=[];



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
      groupedByProperty =  groupBy(_equipmentList, (e) => e.location!.property);
      groupedByPropertyThenLocation = groupEquipment(_equipmentList);

      notifyListeners();
    }
  }







  Map<PropertyModel, Map<LocationModel, List<EquipmentModel>>> groupEquipment(
      List<EquipmentModel> equipmentList) {

    // Group by property
    final groupedByProperty = groupBy(
      equipmentList.where((e) => e.location?.property?.id == null && e.location!.property != null),
          (e) => e.location!.property!,
    );

    // Use SplayTreeMap to keep properties sorted by name
    final orderedByProperty =
    SplayTreeMap<PropertyModel, Map<LocationModel, List<EquipmentModel>>>(
          (a, b) => a.name!.compareTo(b.name ??""),
    );

    for (final entry in groupedByProperty.entries) {
      // Group equipment for this property by location
      final groupedByLocation = groupBy(
        entry.value.where((e) => e.location != null),
            (e) => e.location!,
      );

      // Use SplayTreeMap to keep locations sorted by name
      final orderedByLocation =
      SplayTreeMap<LocationModel, List<EquipmentModel>>(
            (a, b) => a.name!.compareTo(b.name?? ""),
      )..addAll(groupedByLocation);

      orderedByProperty[entry.key] = orderedByLocation;
    }

    return orderedByProperty;
  }







}


