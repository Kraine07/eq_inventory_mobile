




import 'dart:convert';

import 'package:equipment_inventory/Model/modelModel.dart';
import 'package:http/http.dart';

import '../Model/locationModel.dart';
import '../Model/manufacturerModel.dart';
import 'apiService.dart';

class ManufacturerService extends APIService{
  List<ManufacturerModel> _manufacturerList = [];
  List<ModelModel> _modelList = [];


  List<ManufacturerModel> get manufacturerList => _manufacturerList;
  List<ModelModel> get modelList => _modelList;


  set manufacturerList(List<ManufacturerModel> list){
    _manufacturerList = list;
    notifyListeners();
  }



  set modelList(List<ModelModel> list){
    _modelList = list;
    notifyListeners();
  }


  void retrieveManufacturerList() async{

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

  void retrieveModelList() async{
    Response response = await this.get('api/v1/get-all-models',  {});
    if(response.body.isNotEmpty) {
      List<dynamic> returnedList = jsonDecode(response.body);
      returnedList.forEach((item) {
        ModelModel returnedModel = ModelModel.fromJson(item);
        if (!_modelList.any((modelFromList) =>
        returnedModel.manufacturer.id == modelFromList.manufacturer.id &&
            returnedModel.description == modelFromList.description)) {
          _modelList.add(returnedModel);
        }
      });
      _modelList.sort((a, b) =>
          a.manufacturer.name!.compareTo(b.manufacturer.name.toString()));
      notifyListeners();
    }
  }



}