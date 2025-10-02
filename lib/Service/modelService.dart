



import 'dart:convert';

import 'package:equipment_inventory/Service/apiService.dart';
import 'package:http/http.dart';

import '../Model/modelModel.dart';

class ModelService extends APIService{

  List<ModelModel> _modelList = [];


  List<ModelModel> get modelList => _modelList;




  set modelList(List<ModelModel> list){
    _modelList = list;
    notifyListeners();
  }




  void retrieveModelList() async{
    Response response = await this.get('api/v1/get-all-models',  {});
    if(response.body.isNotEmpty) {
      _modelList.clear();
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


  Future<Response?> addModel(Map<String, dynamic> data) async{

    return await this.post(
        endpoint: 'api/v1/save-model',
        data: data
    );
  }


  Future<Response?> deleteModel(Map<String, dynamic> model) async{
    return await this.post(
      endpoint: "api/v1/delete-model",
      data: model,
    );
  }

}