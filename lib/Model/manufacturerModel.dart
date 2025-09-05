


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
        id: BigInt.parse("+${json['id']}"),
        name: json['name']
    );
  }

}