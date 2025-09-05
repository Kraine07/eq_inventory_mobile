


import 'package:equipment_inventory/Model/userModel.dart';
import 'package:equipment_inventory/Service/apiService.dart';
import 'package:http/http.dart';

class UserService extends APIService{
  UserModel? _authUser;
  late bool isLoggedIn = false;

  UserModel? get authUser => _authUser;

  set setAuthUser(UserModel user) {
    _authUser = user;
    notifyListeners();
  }


  Future<Response> login(String endpoint, String email, String password ) async {
    Map<String,dynamic> loginModel ={
      'email' :email,
      'password' : password
    };
    return await this.post(endpoint: endpoint,data: loginModel);
  }



  Future<Response> register(String endpoint, Map<String, dynamic> registrationModel) async {
    return await this.post(endpoint: endpoint, data: registrationModel);
  }
}
