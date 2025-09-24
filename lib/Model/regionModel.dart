

class RegionModel {
  BigInt? id;
  String? name;


  RegionModel({
    required this.id,
    required this.name
  });


  Map<String, dynamic> toJson(){
    return {
      'id' : id.toString(),
      'name' : name
    };
  }


  factory RegionModel.fromJson(Map<String, dynamic> json){
    return RegionModel(
        id: json['id'] != null ? BigInt.parse("+${json['id']}") : null,
        name: json['name']
    );
  }

}