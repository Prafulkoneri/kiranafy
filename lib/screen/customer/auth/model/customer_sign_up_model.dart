///Request Model
class CustomerSignUpRequestModel {
  String? countryCode;
  String? mobileNo;
  String? customerName;
  CustomerSignUpRequestModel({
    this.countryCode,
    this.mobileNo,
    this.customerName,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["customer_country_code"] = countryCode;
    data["customer_mobile_number"] = mobileNo;
    data["customer_name"] = customerName;
    return data;
  }
}

///////////Response Model

class CustomerSignUpResponcesModel {
  int? status;
  String? message;
  SuccessToken? successToken;

  CustomerSignUpResponcesModel({
    required this.status,
    required this.message,
    required this.successToken,
  });
  CustomerSignUpResponcesModel.fromJson(Map<String, dynamic> json) {
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
