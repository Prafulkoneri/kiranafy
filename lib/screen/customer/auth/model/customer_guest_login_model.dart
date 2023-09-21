import 'package:local_supper_market/main.dart';

class CustomerGuestLoginReqModel{
  String? loginType;
  CustomerGuestLoginReqModel({
    this.loginType,
  });
  Map<String,dynamic> toJson(){
    Map<String,dynamic> data={};
    data["login_type"]=loginType;
    return data;
  }
}

class CustomerGuestLoginResModel {
  int? status;
  String? message;
  SuccessToken? successToken;

  CustomerGuestLoginResModel({
    required this.status,
    required this.message,
    required this.successToken,
  });
  CustomerGuestLoginResModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    successToken = json['success_token'] != null
        ? SuccessToken.fromJson(json['success_token'])
        : null;
  }
}

class SuccessToken {
  String? token;

  SuccessToken({
    required this.token,
  });

  SuccessToken.fromJson(Map<String, dynamic> json) {
    token = json["token"];
  }
}