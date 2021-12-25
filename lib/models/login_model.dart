import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ozon_store_app/config.dart';

class LoginResponseModel {
  bool success;
  int statucCode;
  String code;
  String message;
  Data data;

  LoginResponseModel({
    this.success,
    this.statucCode,
    this.code,
    this.message,
    this.data
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statucCode = json['statucCode'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statucCode'] = this.statucCode;
    data['code'] = this.code;
    data['message'] = this.message;

    if(this.data != null) {
      data['data'] = this.data.toJson();
    }

    return data;
  }
}

class Data {
  String token;
  int id;
  String email;
  String nicename;
  String firstName;
  String lastName;
  String displayName;

  Data({
      this.token,
      this.id,
      this.email,
      this.nicename,
      this.firstName,
      this.lastName,
      this.displayName
  });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    email = json['email'];
    nicename = json['nicename'];
    firstName = json['firstName'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['id'] = this.id;
    data['email'] = this.email;
    data['nicename'] = this.nicename;
    data['firstName'] = this.firstName;
    data['displayName'] = this.displayName;

    return data;
  }

  Future<LoginResponseModel> loginCustomer(
    String username,
    String password,
  ) async {
    LoginResponseModel model;

    try {
      var response = await Dio().post(
        Config.tokenURL,
        data: {
          "username": username,
          "password": password,
        },
        options: new Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.statusCode == 200) {
        model = LoginResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return model;
  }
}
