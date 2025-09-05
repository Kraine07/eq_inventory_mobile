


import 'package:equipment_inventory/Model/roleModel.dart';

class UserModel{
  BigInt? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  RoleModel?  role;
  bool? isTemporaryPassword;
  bool? isSuspended;
  int? failedAttempts;
  bool? isAdmin;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    required this.isTemporaryPassword,
    required this.isSuspended,
    required this.failedAttempts,
    required this.isAdmin
  });
  
  
  Map<String, dynamic> toJson(){
    return {
      'id': id.toString(),
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'role': role!.toJson(),
      'isTemporaryPassword': isTemporaryPassword,
      'isSuspended': isSuspended,
      'failedAttempts': failedAttempts,
      'isAdmin': isAdmin
    };
  }
  
  
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
        id: json['id'] != null ? BigInt.parse("+${json['id']}") : null,
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        password: json['password'],
        role: RoleModel.fromJson(json['role']),
        isTemporaryPassword: json['isTemporaryPassword'],
        isSuspended: json['isSuspended'],
        failedAttempts: json['failedAttempts'],
        isAdmin: json['isAdmin']
    );
  }
  
}

