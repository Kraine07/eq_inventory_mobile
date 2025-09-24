


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
      'roleType' : roleType?.name
    };
  }


  factory RoleModel.fromJson(Map<String, dynamic> json){
    return RoleModel(
        id: json['id'] != null ? BigInt.parse("+${json['id']}") : null,
        roleType: json['roleType'] != null ?
          RoleType.values.firstWhere( (e) => e.name == json['roleType'] ) : null,
    );
  }
}