




import 'dart:convert';

import 'package:equipment_inventory/Model/modelModel.dart';
import 'package:http/http.dart';


import '../Model/manufacturerModel.dart';
import 'apiService.dart';

class ManufacturerService extends APIService{
  List<ManufacturerModel> _manufacturerList = [];



  List<ManufacturerModel> get manufacturerList => _manufacturerList;



  set manufacturerList(List<ManufacturerModel> list){
    _manufacturerList = list;
    notifyListeners();
  }






  void retrieveManufacturerList() async{
    _manufacturerList.clear();

    Response response = await this.get('api/v1/get-all-manufacturers',  {});
    if(response.body.isNotEmpty){
      List<dynamic> returnedList = jsonDecode(response.body);
      returnedList.forEach((item){
        ManufacturerModel returnedManufacturer = ManufacturerModel.fromJson(item);
        if (!_manufacturerList.any((modelFromList) => returnedManufacturer.id == modelFromList.id )) {
          _manufacturerList.add(returnedManufacturer);
        }
      });
      _manufacturerList.sort((a, b) => a.name!.compareTo(b.name.toString()));
      notifyListeners();

    }
  }







  Future<Response?> addManufacturer(Map<String, dynamic> data) async{
    return await this.post(
        endpoint: 'api/v1/save-manufacturer',
        data: data
    );
  }


  


  Future<Response?> deleteManufacturer(BigInt? id) async{
    return await this.post(
        endpoint: "api/v1/delete-manufacturer/${id}",
        data: {},

    );
  }

}