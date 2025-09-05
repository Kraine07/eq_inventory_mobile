

import 'package:equipment_inventory/Model/manufacturerModel.dart';

class ModelModel {
  ManufacturerModel manufacturer;
  String? description;

  ModelModel({ required this.manufacturer, required this.description});

  Map<String, dynamic> toJson(){
    return {
      'id': manufacturer.toJson(),
      'description': description
    };
  }

  factory ModelModel.fromJson(Map<String,dynamic> json){
    return ModelModel(
        manufacturer: ManufacturerModel.fromJson(json['manufacturer']),
        description: json['description']
    );
  }
}