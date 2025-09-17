

import 'package:equipment_inventory/Model/propertyModel.dart';

class LocationModel{
  PropertyModel? property;
  String? name;

  LocationModel({ required this.property, required this.name});

  Map<String, dynamic> toJson(){
    return {
      'property' : property!.toJson(),
      'name' : name
    };
  }


  factory LocationModel.fromJson(Map<String, dynamic> json){
    return LocationModel(
        property: PropertyModel.fromJson(json['property']),
        name: json['name']
    );
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LocationModel &&
              runtimeType == other.runtimeType &&
              property?.id == other.property?.id &&
              name == other.name;

  @override
  int get hashCode => Object.hash(property?.id, name);

}