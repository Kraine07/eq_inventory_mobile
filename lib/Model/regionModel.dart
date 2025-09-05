

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
        id: BigInt.parse("+${json['id']}"),
        name: json['name']
    );
  }

}