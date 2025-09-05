


import 'package:equipment_inventory/Model/roleType.dart';

class RoleModel{
  BigInt? id;
  RoleType? roleType;


  RoleModel({
    required this.id,
    required this.roleType
  });

  Map<String, dynamic> toJson(){
    return {
      'id' : id.toString(),
      'roleType' : roleType
    };
  }


  factory RoleModel.fromJson(Map<String, dynamic> json){
    return RoleModel(
        id: BigInt.parse("+${json['id']}"),
        roleType: json['roleType'] != null ?
          RoleType.values.firstWhere( (e) => e.name == json['roleType'] ) : null,
    );
  }
}