///Request Model
class CustomerSignUpRequestModel {
  String? countryCode;
  String? mobileNo;
  String? customerName;
  CustomerSignUpRequestModel({
    this.countryCode,
    this.mobileNo,
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

  CustomerSignUpResponcesModel({
    required this.status,
    required this.message,
  });
  CustomerSignUpResponcesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
