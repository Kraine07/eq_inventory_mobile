


class ManufacturerModel{
  BigInt? id;
  String? name;

  ManufacturerModel({ required this.id, required this.name});

  Map<String, dynamic> toJson(){
    return {
      'id' : id.toString(),
      'name' : name
    };
  }


  factory ManufacturerModel.fromJson(Map<String, dynamic> json){
    return ManufacturerModel(
        id: json['id'] != null ? BigInt.parse("+${json['id']}") : null,
        name: json['name']
    );
  }

}