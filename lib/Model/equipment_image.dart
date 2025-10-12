


import 'dart:typed_data';

import 'package:equipment_inventory/Model/equipmentModel.dart';

class EquipmentImage{

  BigInt? id;
  EquipmentModel? equipment;
  String? imageName;
  Uint8List? imageData;

  EquipmentImage({
    required this.id,
    required this.equipment,
    required this.imageName,
    required this.imageData
  });


  Map<String, dynamic> toJson(){
    return {
      'id': id.toString(),
      'equipment': equipment!.toJson(),
      'imageName': imageName,
      'imageData': imageData
    };
  }

  factory EquipmentImage.fromJson(Map<String, dynamic> json){
    return EquipmentImage(
        id: json['id'] != null ? BigInt.parse("+${json['id']}") : null,
        equipment: EquipmentModel.fromJson(json['equipment']),
        imageName: json['imageName'],
        imageData: json['imageData']

    );
  }

}