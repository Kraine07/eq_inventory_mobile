


import 'package:equipment_inventory/Model/locationModel.dart';
import 'package:equipment_inventory/Model/modelModel.dart';

import '../yearMonth.dart';

class EquipmentModel{
  BigInt? id;
  String? serialNumber;
  YearMonth? manufacturedDate;
  ModelModel? model;
  LocationModel? location;

  EquipmentModel({
    required this.id,
    required this.serialNumber,
    required this.manufacturedDate,
    required this.model,
    required this.location
  });

  Map<String, dynamic> toJson(){
    return {
      'id': id.toString(),
      'serialNumber': serialNumber,
      'manufacturedDate': manufacturedDate.toString(),
      'model' : model!.toJson(),
      'location' : location!.toJson()
    };
  }


  factory EquipmentModel.fromJson(Map<String, dynamic> json){
    return EquipmentModel(
        id: BigInt.parse("+${json['id']}"),
        serialNumber: json['serialNumber'],
        manufacturedDate: json['manufacturedDate'] != null ? YearMonth.fromString(json['manufacturedDate']) : YearMonth(year: 0, month: 0),
        model: ModelModel.fromJson(json['model']),
        location: LocationModel.fromJson(json['location'])
    );
  }

}