

import 'package:equipment_inventory/Model/regionModel.dart';
import 'package:equipment_inventory/Model/userModel.dart';

class PropertyModel{
  BigInt? id;
  String? name;
  RegionModel region;
  UserModel? user;


  PropertyModel({
    required this.id,
    required this.name,
    required this.region,
    required this.user
  });


  Map<String, dynamic> toJson(){
    return {
      'id' : id.toString(),
      'name' : name,
      'region' : region.toJson(),
      'user' : user!.toJson()
    };
  }


  factory PropertyModel.fromJson(Map<String, dynamic> json){
    return PropertyModel(
        id: BigInt.parse("+${json['id']}"),
        name: json['name'],
        region: RegionModel.fromJson(json['region']),
        user: UserModel.fromJson(json['user'])
    );
  }
}