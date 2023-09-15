class LoginReqModel {
  String? countryCode;
  String? mobileNo;
  String? fcmToken;

  LoginReqModel({
    this.countryCode,
    this.mobileNo,
    required this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["shop_owner_mobile_number"] = mobileNo;
    data["shop_owner_country_code"] = countryCode;
    data["shop_owner_fcm_token"] = fcmToken;
    return data;
  }
}

class LoginResModel {
  int? status;
  String? message;
  SuccessToken? successToken;

  LoginResModel({
    this.status,
    this.message,
    this.successToken,
  });

  LoginResModel.fromJson(Map<String, dynamic> json) {
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
    this.token,
  });

  SuccessToken.fromJson(Map<String, dynamic> json) {
    token = json["token"];
  }
}
