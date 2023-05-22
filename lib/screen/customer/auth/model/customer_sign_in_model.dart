import 'package:local_supper_market/main.dart';

class CustomerSignInReqModel{
  String? customerCountryCode;
  String? customerMobileNo;
  String? customerFcmToken;
  CustomerSignInReqModel({
    this.customerCountryCode,
    this.customerFcmToken,
    this.customerMobileNo,
});
  Map<String,dynamic> toJson(){
    Map<String,dynamic> data={};
    data["customer_country_code"]=customerCountryCode;
    data["customer_mobile_number"]=customerMobileNo;
    data["customer_fcm_token"]=fcmToken;
    return data;
  }
}

class CustomerSignInResModel {
  int? status;
  String? message;
  SuccessToken? successToken;

  CustomerSignInResModel({
    required this.status,
    required this.message,
    required this.successToken,
  });
  CustomerSignInResModel.fromJson(Map<String, dynamic> json) {
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