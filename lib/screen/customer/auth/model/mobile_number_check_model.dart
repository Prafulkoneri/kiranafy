//Request Model
class MobileNumberCheckRequestModel {
  String? countryCode;
  String? mobileNo;
  MobileNumberCheckRequestModel({
    this.countryCode,
    this.mobileNo,
  });
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["customer_country_code"] = countryCode;
    data["customer_mobile_number"] = mobileNo;
    return data;
  }
}

////Reponse Model
class MobileNumberCheckResponseModel {
  int? status;
  String? message;

  MobileNumberCheckResponseModel({
    required this.status,
    required this.message,
  });
  MobileNumberCheckResponseModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
