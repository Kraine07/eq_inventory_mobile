


import 'dart:convert';

import 'package:equipment_inventory/Model/userModel.dart';
import 'package:equipment_inventory/Service/apiService.dart';
import 'package:http/http.dart';

class UserService extends APIService{
  List<UserModel> _userList = [];
  UserModel? _authUser;
  bool isLoggedIn = false;



  UserModel? get authUser => _authUser;
  List<UserModel> get userList => _userList;

  set setAuthUser(UserModel user) {
    _authUser = user;
    notifyListeners();
  }

  set setUserList(List<UserModel> list){
    _userList = list;
    notifyListeners();
  }


  Future<Response> login(String endpoint, String email, String password ) async {
    Map<String,dynamic> loginModel ={
      'email' :email,
      'password' : password
    };
    return await this.post(endpoint: endpoint,data: loginModel);
  }



  Future<Response> register({required String endpoint, String? params = null, required Map<String,
      dynamic> registrationModel}) async {
    return await this.post(endpoint: endpoint, data: registrationModel, params: {"role": params});
  }


   void logout() {
    _authUser = null;
    isLoggedIn = false;
    notifyListeners();
  }

  void retrieveList() async{
    Response response = await this.get('api/v1/get-all-users',  {});
    if(response.body.isNotEmpty) {
      List<dynamic> returnedList = jsonDecode(response.body);
      returnedList.forEach((item) {
        UserModel returnedUser = UserModel.fromJson(item);
        // check for duplicates
        if (!_userList.any((userFromUserList) => userFromUserList.id == returnedUser.id)) {
          _userList.add(returnedUser);
        }
      });

      //sort by first name then last mame
      _userList.sort((a, b) {
        int lastNameComparison = a.lastName!.compareTo(b.lastName!);
        if (lastNameComparison != 0) {
          return lastNameComparison; // last names are different
        } else {
          return a.firstName!.compareTo(
              b.firstName!); // last names equal → compare first names
        }
      });

      notifyListeners();
    }
  }
}
