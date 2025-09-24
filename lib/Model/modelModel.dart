

import 'package:equipment_inventory/Model/manufacturerModel.dart';

class ModelModel {
  ManufacturerModel manufacturer;
  String? description;

  ModelModel({ required this.manufacturer, required this.description});

  Map<String, dynamic> toJson(){
    return {
      'manufacturer': manufacturer.toJson(),
      'description': description
    };
  }

  factory ModelModel.fromJson(Map<String,dynamic> json){
    return ModelModel(
        manufacturer: ManufacturerModel.fromJson(json['manufacturer']),
        description: json['description']
    );
  }



  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ModelModel &&
              runtimeType == other.runtimeType &&
              manufacturer.id == other.manufacturer.id && // Assuming PropertyModel has `id`
              description == other.description;

  @override
  int get hashCode => Object.hash(manufacturer.id, description);


}